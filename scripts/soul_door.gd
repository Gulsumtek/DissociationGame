extends StaticBody2D

@export var target_scene_path: String
@export var door_id: String
@export var required_drops: int
@export var door_dialogue: DialogueResource

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact.connect(_on_door_interacted)

func _on_door_interacted():
	var player = get_tree().get_first_node_in_group("Player")

	if Global.soul_fragments_dropped >= required_drops:
		Global.entrance_name = door_id
		TransitionScreen.transition_to(target_scene_path)
	else:
		if player and door_dialogue:
			player.start_dialogue(door_dialogue, "not_ready")
		else:
			print("Henüz hazır değil! Düşürülen: ", Global.soul_fragments_dropped, "/", required_drops)
