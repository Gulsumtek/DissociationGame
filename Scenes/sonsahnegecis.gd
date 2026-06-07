extends Area2D

var already_triggered: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	if already_triggered:
		return
	if body.is_soul_mode:
		return
	
	already_triggered = true
	_trigger_ending(body)

func _trigger_ending(player):
	player.is_frozen = true
	await TransitionScreen.fade_out()
	# Animasyonu başlat
	get_tree().current_scene.play_ending()
	await TransitionScreen.fade_in()
