extends Area2D

@export var fragment_id: String = "auto_1"
var triggered: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if triggered:
		return
	if not body.is_in_group("Player"):
		return
	# Sadece ruh modundayken tetiklensin
	if not body.is_soul_mode:
		return
	
	triggered = true
	body.drop_soul_fragment()
	Global.soul_fragments_dropped += 1
	print("Otomatik fragment düştü! Toplam: ", Global.soul_fragments_dropped)
