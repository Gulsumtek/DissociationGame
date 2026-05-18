extends Control

var buttons = {}
func _ready():
	buttons[$start_button.get_rect()] = _on_start_pressed
	buttons[$end_button.get_rect()] = _on_end_pressed

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		for rect in buttons:
			if rect.has_point(event.position):
				buttons[rect].call()

func _on_start_pressed():
	TransitionScreen.transition_to("res://Scenes/bus_cutscene.tscn")

func _on_end_pressed():
	get_tree().quit()
