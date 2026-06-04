extends Node

@onready var collect_sound = $CollectSound
@onready var drop_sound = $DropSound
@onready var alarm_player = $AlarmPlayer  # AudioStreamPlayer, loop açık

func play_collect():
	collect_sound.play()

func play_drop():
	drop_sound.play()

func play_alarm():
	alarm_player.play()

func stop_alarm():
	alarm_player.stop()
