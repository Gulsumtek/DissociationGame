extends StaticBody2D

# Hangi sahneye gidileceğini editörden seçebilmek için:
@export var target_scene_path : String 
@export var door_id : String # Bu kapının benzersiz adı
@onready var interaction_area = $InteractionArea
#@onready var audio_player = $AudioStreamPlayer2D
func _ready():
	interaction_area.interact.connect(_on_door_interacted)

func _on_door_interacted():
		if target_scene_path == "":
			print("Hata: Hedef sahne yolu girilmemiş!")
		Global.entrance_name = door_id 
		TransitionScreen.transition_to(target_scene_path)
