extends Node2D

@onready var player = $Player
@onready var city_layer = $CityLayer  # Direkt onready ile al

var dialogue_played = false

func _ready():
	city_layer.visible = false
	
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position
	
	await TransitionScreen.fade_in()
	
	if Global.came_from_soul:
		Global.came_from_soul = false
		city_layer.visible = true
		await get_tree().create_timer(0.3).timeout
		player.start_dialogue(
			preload("res://dialogues/school_dialogue.dialogue"), "after_soul"
		)
		return  # intro diyaloğu çıkmasın
	
	if not dialogue_played:
		dialogue_played = true
		player.start_dialogue(
			preload("res://dialogues/school_dialogue.dialogue"), "intro"
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:pass
