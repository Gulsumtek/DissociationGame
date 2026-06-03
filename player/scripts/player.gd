class_name Player
extends CharacterBody2D

var move_speed = 100.0 + (Global.soul_fragments_collected * 5.0)
var last_direction: String = "down"
var is_frozen: bool = false
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine
var is_soul_mode: bool = false
@export var body_speed: float = 100.0
@export var soul_speed: float = 180.0
const MY_BALLOON = preload("res://dialogues/balloon.tscn")
signal dialogue_finished
@onready var soul_light = $soulLight

func _ready() -> void:
	soul_light.visible = false
	state_machine.Initialize(self)
	$InteractionDetector.collision_mask = 10
	var soul_layer = get_tree().current_scene.get_node_or_null("SoulLayer")
	var blackboard_layer = get_tree().current_scene.get_node_or_null("BlackboardLayer")
	if blackboard_layer:
		if is_soul_mode:
			blackboard_layer.visible = false
	if soul_layer:
		soul_layer.visible = false

func _physics_process(delta):
	if is_frozen:
		velocity = Vector2.ZERO
		return

func toggle_soul_mode():
	is_soul_mode = !is_soul_mode
	
	if is_soul_mode:
		var lamps = get_tree().get_nodes_in_group("StreetLamp")
		for lamp in lamps:
			lamp.reset_for_soul_mode()
	
	var body_layer = get_tree().current_scene.get_node_or_null("BodyLayer")
	var soul_layer = get_tree().current_scene.get_node_or_null("SoulLayer")
	var blackboard_layer = get_tree().current_scene.get_node_or_null("BlackboardLayer")
	if blackboard_layer:
		if is_soul_mode:
			blackboard_layer.visible = false
		else:
			blackboard_layer.visible = true
	if is_soul_mode:
		soul_light.visible = true
		move_speed = soul_speed
		$InteractionDetector.collision_mask = 12
		if body_layer:
			body_layer.visible = false
		if soul_layer:
			soul_layer.visible = true
	else:
		soul_light.visible = false
		move_speed = body_speed + (Global.soul_fragments_collected * 5.0)
		$InteractionDetector.collision_mask = 10
		if body_layer:
			body_layer.visible = true
		if soul_layer:
			soul_layer.visible = false

func drop_soul_fragment():
	var fragment_scene = load("res://Scenes/soul_fragment.tscn")
	var fragment = fragment_scene.instantiate()
	SoundManager.play_drop()
	fragment.global_position = global_position
	fragment.fragment_id = "dropped_" + str(Time.get_ticks_msec())
	get_tree().current_scene.call_deferred("add_child", fragment)

func _input(event):
	if is_frozen:
		if event.is_action_pressed("interact"):
			get_viewport().set_input_as_handled()
		return

	if event is InputEventKey and event.pressed and event.keycode == KEY_Q:
		pass
		#toggle_soul_mode()

	if event.is_action_pressed("interact"):
		var areas = $InteractionDetector.get_overlapping_areas()
		print("Toplam area sayısı: ", areas.size())
		for area in areas:
			var parent = area.get_parent()
			print("Area: ", area.name, " Parent: ", parent.name)
			if parent and parent.has_method("trigger_inspect"):
				parent.trigger_inspect()
				return
			if area and area.has_method("trigger_interact"):
				area.trigger_interact()
				return

func start_dialogue(resource: DialogueResource, title: String):
	if is_frozen:
		return
	is_frozen = true
	var balloon = MY_BALLOON.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(resource, title)
	if balloon:
		balloon.tree_exited.connect(_on_dialogue_finished)
	else:
		is_frozen = false

func _on_dialogue_finished():
	if not is_inside_tree():
		return
	await get_tree().create_timer(0.1).timeout
	if not is_inside_tree():
		return
	is_frozen = false
	print("Diyalog bitti, karakter çözüldü.")
	dialogue_finished.emit()
