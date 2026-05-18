extends Control

func _ready():pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if $start.get_rect().has_point(event.position):
			print("Butona tıklandı!")
			get_tree().change_scene_to_file("res://Scenes/bus_cutscene.tscn")


func _on_quit_pressed():
	get_tree().quit()
