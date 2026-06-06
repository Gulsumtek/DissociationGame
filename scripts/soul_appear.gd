extends Area2D

@onready var halo_sound = $AudioStreamPlayer2D
@onready var particles = $GPUParticles2D
@onready var sprite = $AnimatedSprite2D
@export var fragment_id: String

var citylayer = null

func _ready():
	halo_sound.stop()
	particles.emitting = false
	sprite.visible = false  # başta gizle
	
	if Global.collected_fragment_ids.has(fragment_id):
		queue_free()
		return
	
	body_entered.connect(_on_body_entered)
	
	citylayer = get_tree().current_scene.get_node_or_null("CityLayer")
	
	if citylayer:
		print("citylayer bulundu")
		citylayer.visibility_changed.connect(_on_city_layer_visible)
		if citylayer.visible:
			_activate()
	else:
		print("CityLayer bulunamadı: ", get_path())

func _activate():
	print("Fragment aktif oldu: ", fragment_id)
	sprite.visible = true
	halo_sound.play()
	particles.emitting = true

func _on_city_layer_visible():
	print("citylayer visibility changed")
	if citylayer and citylayer.visible:
		_activate()
	else:
		print("city layer isnt visible")
		sprite.visible = false
		halo_sound.stop()
		particles.emitting = false

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	if body.is_soul_mode:
		return
	if not Global.soul_phase_complete:
		print("soul phase isnt complete")
		return
	collect()
func collect():
	SoundManager.play_collect()
	Global.collected_fragment_ids.append(fragment_id)
	Global.soul_fragments_collected += 1
	set_deferred("monitoring", false)
	sprite.hide()
	particles.emitting = true
	await get_tree().create_timer(0.3).timeout
	queue_free()
