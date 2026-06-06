extends Node2D

@onready var anim = $AnimationPlayer
@onready var label = $CanvasLayer/Label

const MY_BALLOON = preload("res://dialogues/balloon.tscn")

func _show_dialogue(resource: DialogueResource, title: String) -> void:
	var balloon = MY_BALLOON.instantiate()
	add_child(balloon)
	balloon.start(resource, title)
	await balloon.tree_exited

func _after_alarm():
	print("_after_alarm başladı")
	
	await _show_dialogue(
		preload("res://dialogues/cafe_alarm.dialogue"), "after_alarm"
	)
	
	await TransitionScreen.fade_out()
	label.text = "Alarm çalmadan önce..."
	label.visible = true
	await get_tree().create_timer(2.0).timeout
	label.visible = false
	anim.play("RESET")
	await _show_dialogue(
		preload("res://dialogues/cafe_alarm.dialogue"), "before_soul"
	)
	await TransitionScreen.fade_in()
	
	anim.play("soul_to_cafe")

func _after_soul_to_cafe():
	await _show_dialogue(
		preload("res://dialogues/cafe_alarm.dialogue"), "after_soul"
	)
	_go_to_cafe()


func _ready():
	label.visible = false
	anim.animation_finished.connect(_on_animation_finished)
	if Global.cafe_soul_done:
		anim.play("barista_talk")
	else:
		anim.play("alarm")

func _on_animation_finished(anim_name: String):
	match anim_name:
		"alarm":
			_after_alarm()
		"barista_talk":
			_go_to_cutscene2()
		"soul_to_cafe":
			_after_soul_to_cafe()

func _go_to_cafe():
	await TransitionScreen.fade_out()
	Global.enter_cafe_as_soul = true
	Global.alarm_triggered = true
	TransitionScreen.transition_to("res://Scenes/cafe.tscn")

func _go_to_cutscene2():
	
	await _show_dialogue(
	preload("res://dialogues/cafe_alarm.dialogue"), "barista_talk")
	await TransitionScreen.fade_out()
	TransitionScreen.transition_to("res://Scenes/cutscenes/CafeCutscene2.tscn")
