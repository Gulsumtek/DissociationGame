class_name Player extends CharacterBody2D

var move_speed = 100.0 + (Global.soul_fragments_collected * 5.0)
var last_direction: String = "down"
var is_frozen: bool = false
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
var is_soul_mode: bool = false
# Ruh ve Beden için hız değerleri
@export var body_speed: float = 100.0
@export var soul_speed: float = 180.0

# player.gd
func _physics_process(delta):
	if is_frozen:
		velocity = Vector2.ZERO
		# State Machine'in hareket ettirmesini engellemek için move_and_slide çağırmıyoruz
		return 

func toggle_soul_mode():
	is_soul_mode = !is_soul_mode
	if is_soul_mode:
		move_speed = soul_speed
	else:
		move_speed = body_speed + (Global.soul_fragments_collected * 5.0)
		# set_collision_layer_value(1, true)

func drop_soul_fragment():
	# SoulFragment sahnesini yükle (Yolun doğru olduğundan emin ol)
	var fragment_scene = load("res://Scenes/soul_fragment.tscn")
	var fragment = fragment_scene.instantiate()
	
	# Parçayı oyuncunun şu anki yerine koy
	fragment.global_position = global_position
	
	# Benzersiz bir ID ver ki geri dönünce silinmesin
	fragment.fragment_id = "dropped_" + str(Time.get_ticks_msec())
	
	# Sahneye ekle
	get_tree().current_scene.add_child(fragment)


func _input(event):
	# 1. DİALOG KONTROLÜ (En yüksek öncelik)
	if is_frozen and DialogueBox.visible:
		# Herhangi bir tuşa basıldı mı? (Sadece basılma anı, basılı tutma değil)
		if event.is_pressed() and not event.is_echo():
			_handle_dialogue_logic()
			# KRİTİK: Girişi burada tüketiyoruz. State Machine bunu duymayacak.
			get_viewport().set_input_as_handled() 
		return
		
	# RUH MODUNA GEÇİŞ (Geçici olarak 'Q' tuşu)
	if event is InputEventKey and event.pressed and event.keycode == KEY_Q:
		toggle_soul_mode()
		
	# 2. ETKİLEŞİM BAŞLATMA (Sadece is_frozen değilse çalışır)
	if event.is_action_pressed("interact"):
		var areas = $InteractionDetector.get_overlapping_areas()
		for area in areas:
			var parent = area.get_parent()
			if parent and parent.has_method("trigger_inspect"):
				is_frozen = true
				parent.trigger_inspect()
				return # Bir etkileşim bulduysak döngüden çık
			if area and area.has_method("trigger_interact"):
				is_frozen = true
				area.trigger_interact()
				return # Bir etkileşim bulduysak döngüden çık
		
	if is_soul_mode and event.is_action_pressed("interact"):
		drop_soul_fragment()
		
func _handle_dialogue_logic():
	if DialogueBox.is_typing:
		DialogueBox.skip_typing()
	else:
		DialogueBox.close()
		is_frozen = false

func _ready() -> void:
	state_machine.Initialize(self)
