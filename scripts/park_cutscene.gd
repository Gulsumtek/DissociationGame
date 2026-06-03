extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var soul = $Soul
@onready var body = $Node2D/Body


func _ready():
	animation_player.play("swinging")
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim):
	print("Animasyon bitti: ", anim)
	match anim:
		"swinging":
			#DialogueManager.show_dialogue_balloon(
				#preload("res://dialogues/bus_cutscene.dialogue"), "stop1"
			#)
			animation_player.play("soul_run")
		"soul_run":
				Global.entrance_name ="park_bridge"
				Global.park_cutscene_finished = true
				TransitionScreen.transition_to("res://Scenes/Park.tscn")
