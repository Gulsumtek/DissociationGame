extends Area2D

var already_triggered: bool = false

func _ready():
	if Global.alarm_triggered:
		queue_free()
		return
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	if already_triggered:
		return
	
	already_triggered = true
	Global.alarm_triggered = true
	get_tree().current_scene.stop_alarm()
	get_tree().current_scene.alarm_sound.play()
