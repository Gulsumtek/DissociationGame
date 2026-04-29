extends Area2D

# Hangi sahneye gidileceğini editörden seçebilmek için:
@export var target_scene_path : String 
@export var door_id : String # Bu kapının benzersiz adı
var is_player_in_range = false

func _ready():
	# Sinyalleri bağla
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player": # Karakterinin adı neyse
		is_player_in_range = true
		# Burada "E tuşuna bas" yazısını gösterebilirsin

func _on_body_exited(body):
	if body.name == "Player":
		is_player_in_range = false
		# Yazıyı gizleyebilirsin

func _process(_delta):
	if is_player_in_range and Input.is_action_just_pressed("interact"):
		enter_house()

func enter_house():
	if target_scene_path == "":
		print("Hata: Hedef sahne yolu girilmemiş!")
		return
	Global.entrance_name = door_id 
	TransitionScreen.transition_to(target_scene_path)
