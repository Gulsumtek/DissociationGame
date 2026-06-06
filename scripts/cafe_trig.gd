extends Area2D

var already_triggered: bool = false
var connected: bool = false

func _ready():
	if Global.cafe_cutscene1_done:
		queue_free()
		return

func _process(_delta):
	if connected or Global.cafe_cutscene1_done:
		return
	if Global.alarm_triggered:
		body_entered.connect(_on_body_entered)
		connected = true

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	if already_triggered:
		return
	
	already_triggered = true
	_trigger_cutscene(body)

func _trigger_cutscene(player):
	get_tree().current_scene.stop_alarm()
	player.is_frozen = true
	await TransitionScreen.fade_out()
	Global.cafe_cutscene1_done = true
	TransitionScreen.transition_to("res://Scenes/cutscenes/CafeCutscene1.tscn")
