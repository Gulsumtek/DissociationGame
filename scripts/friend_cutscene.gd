extends Node2D


@onready var animation_player = $AnimationPlayer
@onready var friend = $Friend
@onready var body = $Body
const MY_BALLOON = preload("res://dialogues/balloon.tscn")


func _ready():
	animation_player.play("friend")
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim):
	print("Animasyon bitti: ", anim)
	match anim:
		"friend":
			await _show_dialogue( 
				preload("res://dialogues/friend.dialogue"), "first")
			animation_player.play("talking")
		"talking":
			await _show_dialogue( 
				preload("res://dialogues/friend.dialogue"), "second")
			animation_player.play("talking_2")
		"talking_2":
			await _show_dialogue( 
				preload("res://dialogues/friend.dialogue"), "third")
			animation_player.play("talking_3")
		"talking_3":
			await _show_dialogue( 
				preload("res://dialogues/friend.dialogue"), "fourth")
			animation_player.play("beforewalk")
		"beforewalk":
			animation_player.play("walking")
			TransitionScreen.fade_out()
			await _show_dialogue(
				preload("res://dialogues/friend.dialogue"), "ara")
			TransitionScreen.fade_in()
		"walking":
			await _show_dialogue( 
				preload("res://dialogues/friend.dialogue"), "fifth")
			Global.entrance_name ="town_up"
			TransitionScreen.transition_to("res://Scenes/town.tscn")

func _show_dialogue(resource: DialogueResource, title: String) -> void:
	var balloon = MY_BALLOON.instantiate()
	add_child(balloon)
	balloon.start(resource, title)
	await balloon.tree_exited


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
