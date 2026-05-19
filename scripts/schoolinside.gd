extends Node2D

@onready var player = $Player # Haritadaki oyuncu düğümün
@onready var blackboard_layer = $BlackboardLayer  # node adını değiştir

func _ready():
	# Ruh modundaysa ve çizim yapılmamışsa gizle
	#if not Global.blackboard_drawn:
		#blackboard_layer.visible = false
	#else:
		#blackboard_layer.visible = true
	# Eğer daha önce bir kapıdan geçildiyses
	if Global.entrance_name != "":
		# Haritadaki tüm çocuk düğümleri kontrol et
		var spawn_point = find_child(Global.entrance_name)
		
		# Eğer o isimde bir Marker2D bulduysa, oyuncuyu oraya taşı
		if spawn_point != null:
			player.global_position = spawn_point.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:pass
