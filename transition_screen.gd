extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.modulate.a = 0

func transition_to(target_scene_path: String):
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target_scene_path)
	animation_player.play("fade_to_normal")

func fade_out():
	animation_player.play("fade_to_black")
	await animation_player.animation_finished

func fade_in():
	animation_player.play("fade_to_normal")
	await animation_player.animation_finished
