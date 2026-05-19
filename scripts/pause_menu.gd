extends CanvasLayer

func _ready():
	hide()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		show()
	else:
		hide()

func _input(event):
	if not visible:
		return
	if event is InputEventMouseButton and event.pressed:
		var pos = event.position
		
		if _check_button($ResumeButton, pos):
			toggle_pause() 
		elif _check_button($MenuButton, pos):
			get_tree().paused = false
			
			hide()
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _check_button(button, pos):
	return button.get_global_rect().has_point(pos)
	
func _on_music_slider_changed(value):
	#BackgroundMusic.stream_paused=true
	pass
