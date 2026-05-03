class_name Player extends CharacterBody2D

var move_speed: float = 100.0
var last_direction: String = "down"
var is_frozen: bool = false
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine

# player.gd
func _physics_process(delta):
	if is_frozen:
		velocity = Vector2.ZERO
		# State Machine'in hareket ettirmesini engellemek için move_and_slide çağırmıyoruz
		return 

func _input(event):
	# 1. DİALOG KONTROLÜ (En yüksek öncelik)
	if is_frozen and DialogueBox.visible:
		# Herhangi bir tuşa basıldı mı? (Sadece basılma anı, basılı tutma değil)
		if event.is_pressed() and not event.is_echo():
			_handle_dialogue_logic()
			# KRİTİK: Girişi burada tüketiyoruz. State Machine bunu duymayacak.
			get_viewport().set_input_as_handled() 
		return

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
func _handle_dialogue_logic():
	if DialogueBox.is_typing:
		DialogueBox.skip_typing()
	else:
		DialogueBox.close()
		is_frozen = false

func _ready() -> void:
	state_machine.Initialize(self)
