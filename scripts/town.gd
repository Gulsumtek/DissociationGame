extends Node2D

@onready var player = $Player
@onready var alarm_sound = $AlarmSound

func _ready():
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position
		player.is_frozen = false
	if Global.park_cutscene_finished and not Global.cafe_cutscene1_done and not Global.cafe_completed:
		Global.alarm_triggered = true
		alarm_sound.play()

func stop_alarm():
	alarm_sound.stop()
