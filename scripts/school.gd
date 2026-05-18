extends Node2D
@onready var player = $Player # Haritadaki oyuncu düğümün
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		await get_tree().process_frame
		player.start_dialogue(
			preload("res://dialogues/school_dialogue.dialogue"), "intro"
			)
	# Eğer daha önce bir kapıdan geçildiyse
	if Global.entrance_name != "":
		# Haritadaki tüm çocuk düğümleri kontrol et
		var spawn_point = find_child(Global.entrance_name)
		
		# Eğer o isimde bir Marker2D bulduysa, oyuncuyu oraya taşı
		if spawn_point != null:
			player.global_position = spawn_point.global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:pass
