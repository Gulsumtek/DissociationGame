extends Node2D


@onready var animation_player = $AnimationPlayer
@onready var friend = $Friend
@onready var body = $Body


func _ready():
	animation_player.play("friend")
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim):
	print("Animasyon bitti: ", anim)
	match anim:
		"friend":
			#DialogueManager.show_dialogue_balloon(
				#preload("res://dialogues/bus_cutscene.dialogue"), "stop1"
			animation_player.play("talking")
		"talking":
				Global.entrance_name ="town_up"
				TransitionScreen.transition_to("res://Scenes/Town.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
