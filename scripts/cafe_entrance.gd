extends StaticBody2D

@export var target_scene_path: String
@export var door_id: String
@export var locked_dialogue: DialogueResource
@onready var sound = $AudioStreamPlayer
@onready var sound2 = $sound2
@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact.connect(_on_door_interacted)

func _on_door_interacted():
	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		return
	
	if not Global.alarm_triggered:
		# Alarm çalmadan kilitli
		if locked_dialogue:
			player.start_dialogue(locked_dialogue, "start")
		else:
			print("Kafe kilitli!")
		return
	
	if Global.cafe_cutscene1_done and not Global.enter_cafe_as_soul:
		# Normal giriş, beden modu
		Global.entrance_name = door_id
		sound.play()
		sound2.play()
		TransitionScreen.transition_to(target_scene_path)
	elif not Global.cafe_cutscene1_done:
		# cafe_trig tetiklenecek, kapıya gerek yok
		return
