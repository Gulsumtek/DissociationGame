extends StaticBody2D

@onready var anim = $AnimatedSprite2D
@onready var light = $PointLight2D
func _ready():
	# Sinyalleri doğrudan bu script üzerinden bağlayalım
	light.enabled = true
	var area = $DetectionArea
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	# Giren alan oyuncunun dedektörü mü?
	if area.name == "InteractionDetector":
		var player = area.get_parent()
		
		if player.is_soul_mode:
			print("soul mode'da,, flicker yapılıyor.")
			# Ruh modundaysa otomatik oynat
			play_flicker()
		else:
			# Beden modundaysa (İstersen buraya bir print koyabilirsin)
			print("Beden yaklaştı, E tuşu mekaniği buraya yazılabilir")

func _on_area_exited(area):
	if area.name == "InteractionDetector":
		# Oyuncu uzaklaştığında bir şey yapmak istersen buraya yaz
		pass

func _process(_delta):
	# Eğer flicker animasyonu oynuyorsa ışığı kareye göre ayarla
	if anim.animation == "flicker" and anim.is_playing():
		# ÖRNEK: 1. ve 3. karelerde lamba "yanıyor" farz edelim
		if anim.frame == 1 or anim.frame == 3:
			light.enabled = false
		else:
			light.enabled = true
	elif anim.animation == "default":
		light.enabled = true

func play_flicker():
	if anim.animation != "flicker":
		print("flickering")
		anim.play("flicker")
		await anim.animation_finished
		print("flickering stopped")
		anim.play("default")

# Player.gd'den çağrılacak etkileşim fonksiyonu
func trigger_echo():
	play_flicker()
