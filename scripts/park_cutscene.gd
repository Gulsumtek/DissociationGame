extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var soul = $Soul
@onready var body = $Node2D/Body

const MY_BALLOON = preload("res://dialogues/balloon.tscn")

func _show_dialogue(resource: DialogueResource, title: String) -> void:
	var balloon = MY_BALLOON.instantiate()
	add_child(balloon)
	balloon.start(resource, title)
	await balloon.tree_exited
	
func _ready():
	animation_player.play("swinging")
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim):
	print("Animasyon bitti: ", anim)
	match anim:
		"swinging":
			await _show_dialogue( 
				preload("res://dialogues/park.dialogue"), "second")
			animation_player.play("soul_run")
			_show_dialogue(
				preload("res://dialogues/park.dialogue"), "third")
		"soul_run":
				
			# park_cutscene.gd'de soul_run bitince:
				Global.is_soul_mode = false
				Global.entrance_name ="park_bridge"
				Global.park_cutscene_finished = true
				TransitionScreen.transition_to("res://Scenes/park.tscn")
