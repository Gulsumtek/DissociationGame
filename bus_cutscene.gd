extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var soul = $Characters/Soul
@onready var body = $Characters/Body

var dialogue_shown = false
@onready var bus_sound = $AudioStreamPlayer

func _ready():
	bus_sound.play()
	animation_player.play("drive")
	print("Body visible: ", body.visible)
	print("Body pozisyon: ", body.position)
	print("Body modulate: ", body.modulate)
	DialogueManager.dialogue_ended.connect(_on_dialogue_finished)
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play("black")

func _on_animation_finished(anim_name):
	print("Animasyon bitti: ", anim_name)
	match anim_name:
		"black":
			DialogueManager.show_dialogue_balloon(
				preload("res://dialogues/bus_cutscene.dialogue"), "stop1"
			)
			bus_sound.play()
		"drive":
			bus_sound.play()
			animation_player.play("soul_exit")
		"soul_exit":
			bus_sound.play()
			DialogueManager.show_dialogue_balloon(
				preload("res://dialogues/bus_cutscene.dialogue"), "stop2"
			)
			bus_sound.play()
		"drive_2":
			# 2. durak diyaloğu
			animation_player.play("body_exit")
		"body_exit":
			animation_player.play("bus_last")
			bus_sound.play()
		"bus_last":
			bus_sound.play()
			# Cutscene bitti
			TransitionScreen.transition_to("res://scenes/School.tscn")

func _on_dialogue_finished(resource):
	if not dialogue_shown:
		dialogue_shown = true
		animation_player.play("drive")
	else:
		animation_player.play("drive_2")
