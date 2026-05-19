# soul_fragment.gd
extends Area2D
@onready var halo_sound = $AudioStreamPlayer2D  # 2D çünkü mesafeye göre değişsin

@onready var particles = $GPUParticles2D
@onready var sprite = $AnimatedSprite2D
@export var fragment_id: String # Her parça için benzersiz bir isim (örn: "okul_1", "okul_2")

func _ready():
	halo_sound.play()  # loop açık olsun
	if Global.collected_fragment_ids.has(fragment_id):
		queue_free() # Eğer listede varsa, sahneye hiç girmeden kendini yok et
		return
	# Player'ın InteractionDetector'ı değil, gövdesi çarpsın istiyoruz
	body_entered.connect(_on_body_entered)
	particles.emitting = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		# KRİTİK KONTROL: Eğer oyuncu Ruh modundaysa toplama işlemini yapma
		if body.is_soul_mode:
			return
		collect()
		
func collect():
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
