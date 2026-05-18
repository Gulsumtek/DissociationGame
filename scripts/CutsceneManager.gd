extends Node2D

@onready var visual_rect = $TextureRect
@onready var anim_player = $AnimationPlayer

signal cutscene_finished

var is_playing: bool = false

func play_cutscene(cutscene_node: Node):
	is_playing = true
	cutscene_node.visible = true
	cutscene_node.play()

func end_cutscene():
	is_playing = false
	cutscene_finished.emit()
func _ready():
	visual_rect.hide() # Başlangıçta görseller gizli

# Diyalog içinden çağıracağın fonksiyon
func show_memory_visual(texture_path: String):
	var tex = load(texture_path)
	visual_rect.texture = tex
	visual_rect.show()
	anim_player.play("fade_in") # Görselin yavaşça belirmesi için

func hide_visual():
	anim_player.play("fade_out")
	await anim_player.animation_finished
	visual_rect.hide()
