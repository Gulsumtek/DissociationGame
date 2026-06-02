extends Node2D

@onready var player = $Player # Haritadaki oyuncu düğümün

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.entrance_name != "":
		var spawn_point = find_child(Global.entrance_name)
		if spawn_point != null:
			player.global_position = spawn_point.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:pass
