extends Node2D

@onready var player = $Player
@onready var city_layer = $CityLayer  # Direkt onready ile al

var dialogue_played = false
func _ready():
	city_layer.visible = false
	
	var from_soul = Global.came_from_soul
	Global.came_from_soul = false
	
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position
	
	print("soul_phase_complete: ", Global.soul_phase_complete)
	print("from_soul: ", from_soul)
	
	await TransitionScreen.fade_in()
	
	if from_soul or Global.soul_phase_complete:
		city_layer.visible = true
		_activate_soul_fragments()
		if from_soul:
			await get_tree().create_timer(0.3).timeout
			player.start_dialogue(
				preload("res://dialogues/school_dialogue.dialogue"), "after_soul"
			)
		return
	
	if not dialogue_played:
		dialogue_played = true
		player.start_dialogue(
			preload("res://dialogues/school_dialogue.dialogue"), "intro"
		)

func _activate_soul_fragments():
	var fragments = []
	for node in get_children():
		if node.has_method("_activate"):
			fragments.append(node)
	for node in get_tree().get_nodes_in_group("SoulFragment"):
		fragments.append(node)
	
	print("Bulunan fragment sayısı: ", fragments.size())
	for fragment in fragments:
		fragment._activate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:pass
