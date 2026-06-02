# soul_fragment.gd
extends Area2D
@onready var halo_sound = $AudioStreamPlayer2D  # 2D çünkü mesafeye göre değişsin

@onready var particles = $GPUParticles2D
@onready var sprite = $AnimatedSprite2D
@export var fragment_id: String # Her parça için benzersiz bir isim (örn: "okul_1", "okul_2")
@onready var citylayer = $"../../CityLayer"
func _ready():
	# Ses ve partiküller başta kapalı
	halo_sound.stop()
	particles.emitting = false
	
	if Global.collected_fragment_ids.has(fragment_id):
		queue_free()
		return
	
	body_entered.connect(_on_body_entered)
	
	# CityLayer'ın görünürlüğünü izle
	citylayer.visibility_changed.connect(_on_city_layer_visible)
	
	# Eğer zaten görünürse hemen başlat
	if citylayer.visible:
		halo_sound.play()
		particles.emitting = true

func _on_city_layer_visible():
	if citylayer.visible:
		halo_sound.play()
		particles.emitting = true
	else:
		halo_sound.stop()
		particles.emitting = false

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# KRİTİK KONTROL: Eğer oyuncu Ruh modundaysa toplama işlemini yapma
		if body.is_soul_mode:
			return
		collect()
		
func collect():
	if  Global.came_from_soul:
		SoundManager.play_collect()
		Global.collected_fragment_ids.append(fragment_id)
		Global.soul_fragments_collected += 1
		# Çarpışmayı ve görseli kapat
		set_deferred("monitoring", false)
		sprite.hide()
		# Varsa partikül efektini çalıştır
		particles.emitting = true
		
		await get_tree().create_timer(0.3).timeout
		queue_free()
