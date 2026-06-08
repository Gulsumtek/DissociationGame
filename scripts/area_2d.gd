extends Area2D

@export_file("*.tscn") var hedef_harita_yolu: String
@export var door_id: String
@export var required_fragments: int
@export var door_dialogue: DialogueResource
@export var trigger_dialogue: DialogueResource
@export var switches_to_soul: bool = false
@export var soul_can_pass: bool = true  # Varsayılan: ruh geçebilir

var already_triggered: bool = false

func _on_body_entered(body):
	if Global.park_cutscene_finished:
		return
	if not body.is_in_group("Player"):
		return
	if already_triggered:
		return
	
	already_triggered = true
	Global.entrance_name = door_id
	
	if Global.soul_fragments_collected >= required_fragments:
		if switches_to_soul:
			_switch_to_soul_mode.call_deferred(body)
		elif hedef_harita_yolu != "":
			TransitionScreen.transition_to.call_deferred(hedef_harita_yolu)
	else:
		if door_dialogue:
			body.start_dialogue(door_dialogue, "start")

func _switch_to_soul_mode(player):
	if trigger_dialogue:
		player.start_dialogue(trigger_dialogue, "start")
		await player.dialogue_finished
	
	await TransitionScreen.fade_out()
	player.toggle_soul_mode()
	
	var swing = get_tree().current_scene.get_node_or_null("swing")
	if swing:
		swing.play("stop")
	
	var spawn_point = get_tree().current_scene.find_child(door_id)
	if spawn_point:
		player.global_position = spawn_point.global_position
	
	await TransitionScreen.fade_in()
	player.is_frozen = false
