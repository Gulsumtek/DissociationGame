extends Node

@onready var collect_sound = $CollectSound
@onready var drop_sound = $DropSound

func play_collect():
	collect_sound.play()

func play_drop():
	drop_sound.play()
