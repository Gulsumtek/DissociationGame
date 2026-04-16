class_name StateIdle extends State
# Inspector'dan "Walk" düğümünü buraya sürükleyip bırakacağız
@export var walk_state: State

func Enter() -> void:
	# Karakter bu state'e girdiğinde en son baktığı yöne göre idle animasyonu oynatır [cite: 7]
	if player.last_direction == "right":
		player.anim_sprite.play("idle_right")
		player.anim_sprite.flip_h = false
	elif player.last_direction == "left":
		player.anim_sprite.play("idle_right")
		player.anim_sprite.flip_h = true
	elif player.last_direction == "down":
		player.anim_sprite.play("idle_down")
	elif player.last_direction == "up":
		player.anim_sprite.play("idle_up")

func Physics(_delta: float) -> State:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Eğer bir yön tuşuna basıldıysa Walk state'ine geç
	if direction != Vector2.ZERO:
		return walk_state
		
	# Tuşa basılmadıysa bu state'de kalmaya devam et
	return null
