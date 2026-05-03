class_name StateWalk extends State

# Inspector'dan "Idle" düğümünü buraya sürükleyip bırakacağız
@export var idle_state: State

func Physics(_delta: float) -> State:
	if player.is_frozen:
		return idle_state
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Eğer tuşlara basmayı bıraktıysa Idle state'ine geç
	if direction == Vector2.ZERO:
		return idle_state
		
	# Hareket mantığı
	direction = direction.normalized()
	player.velocity = direction * player.move_speed
	player.move_and_slide()
	
	# Animasyon mantığı
	if abs(direction.x) > abs(direction.y):
		player.anim_sprite.play("run_right")
		if direction.x > 0: # Sağa gidiyor
			player.anim_sprite.flip_h = false
			player.last_direction = "right"
		else: # Sola gidiyor
			player.anim_sprite.flip_h = true
			player.last_direction = "left"
	else:
		if direction.y > 0: # Aşağı gidiyor
			player.anim_sprite.play("run_down")
			player.last_direction = "down"
		else: # Yukarı gidiyor
			player.anim_sprite.play("run_up")
			player.last_direction = "up"
			
	# State değişmeyeceği için null döndürüyoruz
	return null
