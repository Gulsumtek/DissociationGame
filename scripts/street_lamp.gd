extends StaticBody2D

@export var flicker: bool = false

@onready var anim = $AnimatedSprite2D
@onready var light = $PointLight2D

var flicker_timer: float = 0.0
var next_flicker: float = 0.0
var permanently_flickering: bool = false

func _ready():
	add_to_group("StreetLamp")
	light.enabled = true
	anim.play("default")
	
	var area = $DetectionArea
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)
	
	var player = get_tree().get_first_node_in_group("Player")
	if flicker and (player == null or not player.is_soul_mode):
		permanently_flickering = true
		next_flicker = randf_range(0.1, 0.5)

func reset_for_soul_mode():
	permanently_flickering = false
	light.enabled = true
	anim.modulate.a = 1.0
	
func _process(delta: float) -> void:
	if not permanently_flickering:
		return
	
	flicker_timer += delta
	
	if flicker_timer >= next_flicker:
		flicker_timer = 0.0
		next_flicker = randf_range(0.1, 0.8)
		
		var on = not light.enabled
		light.enabled = on
		anim.play("flicker")
		light.modulate.a = 1.0 if on else 0.2
		anim.play("default")

func _on_area_entered(area):
	if area.name == "InteractionDetector":
		var player = area.get_parent()
		if player.is_soul_mode and not permanently_flickering:
			permanently_flickering = true
			next_flicker = randf_range(0.05, 0.3)

func _on_area_exited(area):
	pass
