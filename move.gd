extends Node2D

@onready var player = $Player
@onready var swing = $swing

var cutscene_checked: bool = false

func _ready():
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position
	
	if Global.park_cutscene_finished:
		swing.play("stop")
	else:
		swing.play("no_soul")

func _process(_delta):
	if not cutscene_checked and Global.park_cutscene_finished:
		cutscene_checked = true
		swing.play("stop")
