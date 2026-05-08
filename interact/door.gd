extends StaticBody2D

# Hangi sahneye gidileceğini editörden seçebilmek için:

@export var target_scene_path : String 
@export var door_id : String # Bu kapının benzersiz adı
@onready var interaction_area = $InteractionArea
@export var required_fragments: int # Bu kapı için gereken parça sayısı
#@onready var audio_player = $AudioStreamPlayer2D
@export var door_dialogue: DialogueResource

func _ready():
	interaction_area.interact.connect(_on_door_interacted)

func _on_door_interacted():
	if target_scene_path == "":
			print("Hata: Hedef sahne yolu girilmemiş!")
	Global.entrance_name = door_id 
	if Global.soul_fragments_collected >= required_fragments:
		TransitionScreen.transition_to(target_scene_path)
	else:# Oyuncuya henüz hazır olmadığını söyleyen bir diyalog çıkar
		#DialogueBox.show_text("Henüz tüm parçalarımı bulamadım. Kendimi çok ağır hissediyorum...")
		var player = get_tree().get_first_node_in_group("Player")
		if player and door_dialogue:
			player.start_dialogue(door_dialogue, "fragments")
		else:
			print("Diyalog dosyası veya oyuncu bulunamadı!")
