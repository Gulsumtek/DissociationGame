extends Node2D

@onready var anim = $AnimationPlayer

func _ready():
	anim.animation_finished.connect(_on_animation_finished)
	anim.play("cafe_talk")

func _on_animation_finished(anim_name: String):
	if anim_name == "cafe_talk":
		_start_dialogue()

func _start_dialogue():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.start_dialogue(
			preload("res://dialogues/cafe_cutscene_2.dialogue"), "start"
		)
		await player.dialogue_finished
	
	await TransitionScreen.fade_out()
	Global.cafe_cutscene2_done = true
	TransitionScreen.transition_to("res://Scenes/Cafe.tscn")
