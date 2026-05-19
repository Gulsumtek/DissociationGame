class_name StateWalk extends State
var step_timer: float = 0.0
@export var step_interval: float = 0.4  # Her adım arası saniye
# Inspector'dan "Idle" düğümünü buraya sürükleyip bırakacağız
@export var idle_state: State
@onready var walk_sound = $"../../AudioStreamPlayer"

func Enter() -> void:
	step_timer = 0.0

func Physics(_delta: float) -> State:
	if player.is_frozen:
		walk_sound.stop()
		return idle_state
	
	step_timer -= _delta
	if step_timer <= 0.0:
		if player.is_soul_mode==false:
			walk_sound.play()
		step_timer = step_interval
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
		if player.is_soul_mode==true:
			player.anim_sprite.play("soul_run_right")
		else:
			player.anim_sprite.play("run_right")
		if direction.x > 0: # Sağa gidiyor
			player.anim_sprite.flip_h = false
			player.last_direction = "right"
		else: # Sola gidiyor
			player.anim_sprite.flip_h = true
			player.last_direction = "left"
	else:
		if direction.y > 0: # Aşağı gidiyor
			if player.is_soul_mode==true:
				player.anim_sprite.play("soul_run_down")
			else:
				player.anim_sprite.play("run_down")
			player.last_direction = "down"
		else: # Yukarı gidiyor
			if player.is_soul_mode==true:
				player.anim_sprite.play("soul_run_up")
			else:
				player.anim_sprite.play("run_up")
			player.last_direction = "up"
			
	# State değişmeyeceği için null döndürüyoruz
	return null
	
func Exit() -> void:
	walk_sound.stop()
	step_timer = 0.0
