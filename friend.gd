extends Area2D

var already_triggered: bool = false

func _ready():
	if not Global.park_cutscene_finished:
		visible = false
		monitoring = false
		return
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	if already_triggered:
		return
	
	already_triggered = true
	var player = body
	_trigger_friend_scene(player)

func _trigger_friend_scene(player):
	player.is_frozen = true
	await TransitionScreen.fade_out()
	TransitionScreen.transition_to("res://Scenes/cutscenes/friend_cutscene.tscn")
