extends StaticBody2D

@export var target_scene_path: String
@export var door_id: String
@export var required_drops: int
@export var door_dialogue: DialogueResource
@export var switches_to_body: bool = false
@onready var sound = $AudioStreamPlayer
@onready var sound2 = $sound2
@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact.connect(_on_door_interacted)


func _on_door_interacted():
	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		return
	if Global.soul_fragments_dropped >= required_drops:
		Global.came_from_soul = true
		Global.soul_phase_complete = true  # bunu ekle
		print("soul complete")
		await TransitionScreen.fade_out()
		player.toggle_soul_mode()
		Global.entrance_name = door_id
		sound.play()
		sound2.play()
		get_tree().change_scene_to_file(target_scene_path)
	else:
		if player and door_dialogue:
			player.start_dialogue(door_dialogue, "start")
			
func _switch_to_body_mode(player):
	await TransitionScreen.fade_out()
	player.toggle_soul_mode()
	var city_layer = get_tree().current_scene.get_node_or_null("CityLayer")
	if city_layer:
		city_layer.visible = true
	await TransitionScreen.fade_in()
