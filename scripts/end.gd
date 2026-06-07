extends Node2D

@onready var player = $Player2
@onready var anim = $AnimationPlayer
@onready var label = $Player2/CanvasLayer/Label

const MY_BALLOON = preload("res://dialogues/balloon.tscn")

func _ready():
	label.visible = false
	label.modulate.a = 0.0
	
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position

func play_ending():
	anim.animation_finished.connect(_on_animation_finished)
	anim.play("end")

func _on_animation_finished(anim_name: String):
	match anim_name:
		"end":
			await _show_dialogue("after_end")
			anim.play("end_2")
		"end_2":
			await _show_dialogue("after_end_2")
			anim.play("end_3")
		"end_3":
			await _show_dialogue("after_end_3")
			anim.play("end_4")
		"end_4":
			await _show_final_text()

func _show_dialogue(title: String) -> void:
	var balloon = MY_BALLOON.instantiate()
	add_child(balloon)
	balloon.start(preload("res://dialogues/ending.dialogue"), title)
	await balloon.tree_exited

func _show_final_text():
	await TransitionScreen.fade_out()
	label.visible = true
	
	# Yavaşça belir
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 2.0)
	await tween.finished
	
	await get_tree().create_timer(5.0).timeout
	
	# Yavaşça kaybol
	tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 2.0)
	await tween.finished
	
	await TransitionScreen.fade_in()
	await get_tree().create_timer(1.0).timeout
	await TransitionScreen.fade_out()
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
