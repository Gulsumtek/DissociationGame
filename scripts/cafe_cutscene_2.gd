extends Node2D

@onready var anim = $AnimationPlayer
const MY_BALLOON = preload("res://dialogues/balloon.tscn")

func _ready():
	anim.animation_finished.connect(_on_animation_finished)
	anim.play("cafe_talk")

func _show_dialogue(resource: DialogueResource, title: String) -> void:
	var balloon = MY_BALLOON.instantiate()
	add_child(balloon)
	balloon.start(resource, title)
	await balloon.tree_exited

func _on_animation_finished(anim_name: String):
	if anim_name == "cafe_talk":
		_start_dialogue()

func _start_dialogue():
	await _show_dialogue(
		preload("res://dialogues/cafe_cutscene_2.dialogue"), "start"
	)
	await TransitionScreen.fade_out()
	Global.cafe_cutscene2_done = true
	Global.cafe_completed = true
	Global.is_soul_mode = false
	TransitionScreen.transition_to("res://Scenes/cafe.tscn")
