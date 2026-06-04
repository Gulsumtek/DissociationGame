extends StaticBody2D

@export var required_drops: int = 2
@export var door_dialogue: DialogueResource
@onready var area=$InteractionArea
var already_triggered: bool = false

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	if already_triggered:
		return
	
	var player = body
	
	if player.is_soul_mode:
		_handle_soul_exit(player)
	else:
		_handle_body_exit(player)

func _handle_soul_exit(player):
	if Global.soul_fragments_dropped < required_drops:
		if door_dialogue:
			player.start_dialogue(door_dialogue, "start")
		return
	
	already_triggered = true
	_trigger_alarm(player)

func _handle_body_exit(player):
	if not Global.cafe_cutscene2_done:
		return
	
	already_triggered = true
	player.is_frozen = true
	await TransitionScreen.fade_out()
	Global.entrance_name = "cafe"
	TransitionScreen.transition_to("res://Scenes/town.tscn")

func _trigger_alarm(player):
	SoundManager.play_alarm()
	player.is_frozen = true
	await TransitionScreen.fade_out()
	Global.cafe_soul_done = true
	Global.enter_cafe_as_soul = false
	TransitionScreen.transition_to("res://Scenes/cutscenes/CafeCutscene1.tscn")
