extends CanvasLayer

func _ready():
	var os_name = OS.get_name()
	if os_name == "Android" or os_name == "iOS":
		show()
	elif os_name == "Web" and DisplayServer.has_feature(DisplayServer.FEATURE_TOUCHSCREEN):
		show()
	else:
		hide()
