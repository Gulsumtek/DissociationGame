extends Node2D

@onready var player = $Player
@onready var alarm_sound = $AlarmSound

func _ready():
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position
	
	if Global.alarm_triggered and not Global.cafe_cutscene1_done:
		alarm_sound.play()

func stop_alarm():
	alarm_sound.stop()
