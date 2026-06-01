extends StaticBody2D

@export var target_scene_path: String
@export var door_id: String
@export var required_fragments: int
@export var max_fragments: int = 100
@export var door_dialogue: DialogueResource
@export var end_dialogue: DialogueResource
@export var switches_to_soul: bool = false  # Bunu işaretlersen mod geçişi yapar, sahne geçişi yapmaz
@onready var sound = $AudioStreamPlayer
@onready var sound2 = $sound2

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact.connect(_on_door_interacted)

func _on_door_interacted():
	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		return
	Global.entrance_name = door_id
	if Global.soul_fragments_collected >= max_fragments:
		player.start_dialogue(end_dialogue, "start")
		return
	if Global.soul_fragments_collected >= required_fragments:
		if switches_to_soul:
			_switch_to_soul_mode(player)
		else:
			sound.play()
			sound2.play()
			TransitionScreen.transition_to(target_scene_path)
	else:
		if player and door_dialogue:
			player.start_dialogue(door_dialogue, "start")
		else:
			print("Diyalog veya oyuncu bulunamadı!")

func _switch_to_soul_mode(player):
	await TransitionScreen.fade_out()
	player.start_dialogue(door_dialogue, "switch")
	await player.dialogue_finished
	player.toggle_soul_mode()
	await TransitionScreen.fade_in()
