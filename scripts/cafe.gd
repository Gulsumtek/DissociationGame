extends Node2D

@onready var player = $Player
@onready var barista = $Barista
@onready var object = $StaticBody2D
@onready var soul_fragments_layer = $SoulFragmentsLayer

func _ready():
	player.toggle_soul_mode()
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position
	
	if Global.enter_cafe_as_soul and not player.is_soul_mode:
		player.toggle_soul_mode()
		Global.enter_cafe_as_soul = false
		barista.visible = false
		object.visible = false
		soul_fragments_layer.visible = false
	
	elif Global.cafe_soul_done and not Global.cafe_cutscene2_done:
		# Beden olarak girdi, ruh parçaları görünsün
		barista.visible = true
		object.visible = true
		soul_fragments_layer.visible = true
