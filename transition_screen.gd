extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	# Oyun başladığında ekran siyah kalmasın diye gizliyoruz
	color_rect.modulate.a = 0

func transition_to(target_scene_path: String):
	# Ekranı karart
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	# Sahneyi değiştir
	get_tree().change_scene_to_file(target_scene_path)
	
	# Ekranı aydınlat
	animation_player.play("fade_to_normal")
