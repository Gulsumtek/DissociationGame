extends Area2D

var already_triggered: bool = false

func _ready():
	if Global.cafe_cutscene1_done:
		queue_free()
		return
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Body entered: ", body.name)
	if not body.is_in_group("Player"):
		return
	if already_triggered:
		return
	
	already_triggered = true
	var player = body
	_trigger_cutscene(player)

func _trigger_cutscene(player):
	get_tree().current_scene.stop_alarm()
	player.is_frozen = true
	await TransitionScreen.fade_out()
	Global.cafe_cutscene1_done = true
	TransitionScreen.transition_to("res://Scenes/cutscenes/CafeCutscene1.tscn")
