

extends StaticBody2D

@export var target_scene_path: String
@export var door_id: String
@export var required_drops: int
@export var door_dialogue: DialogueResource
@export var switches_to_body: bool = false
@onready var sound = $AudioStreamPlayer
@onready var sound2 = $sound2
@onready var interaction_area = $InteractionArea
const MY_BALLOON = preload("res://dialogues/balloon.tscn")

var already_triggered: bool = false

func _ready():
	interaction_area.interact.connect(_on_door_interacted)

func _on_door_interacted():
	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		return
	_handle_soul_exit(player)


func _show_dialogue(resource: DialogueResource, title: String) -> void:
	var balloon = MY_BALLOON.instantiate()
	add_child(balloon)
	balloon.start(resource, title)
	await balloon.tree_exited

	
	
func _handle_soul_exit(player):
	if Global.soul_fragments_dropped >= required_drops:
			await _show_dialogue(
			preload("res://dialogues/cafe_alarm.dialogue"), "soul_alarm")
			sound.play()
			sound2.play()
			_switch_to_body_mode(player)
	if door_dialogue:
		player.start_dialogue(door_dialogue, "start")
	return



func _switch_to_body_mode(player):
	player.is_frozen = true
	await TransitionScreen.fade_out()
	Global.cafe_soul_done = true
	Global.enter_cafe_as_soul = false
	player.toggle_soul_mode()
	get_tree().change_scene_to_file(target_scene_path)
	await TransitionScreen.fade_in()
	
