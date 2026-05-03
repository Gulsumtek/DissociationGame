# soul_fragment.gd
extends Area2D

@onready var particles = $GPUParticles2D
@onready var sprite = $AnimatedSprite2D
@export var fragment_id: String # Her parça için benzersiz bir isim (örn: "okul_1", "okul_2")
func _ready():
	if Global.collected_fragment_ids.has(fragment_id):
		queue_free() # Eğer listede varsa, sahneye hiç girmeden kendini yok et
		return
	# Player'ın InteractionDetector'ı değil, gövdesi çarpsın istiyoruz
	body_entered.connect(_on_body_entered)
	particles.emitting = true
func _on_body_entered(body):
	if body.is_in_group("Player"):
		collect()
			
func collect():
	Global.collected_fragment_ids.append(fragment_id)
	Global.soul_fragments_collected += 1
	
	# Çarpışmayı ve görseli kapat
	set_deferred("monitoring", false)
	sprite.hide()
	# Varsa partikül efektini çalıştır
	particles.emitting = true
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
