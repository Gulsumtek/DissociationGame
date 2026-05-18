extends Area2D

@export_file("*.tscn") var hedef_harita_yolu: String
@export var door_id : String # Bu kapının benzersiz adı
@export var required_fragments: int # Bu kapı için gereken parça sayısı
@export var door_dialogue: DialogueResource
#@onready var audio_player = $AudioStreamPlayer2D


func _on_body_entered(body):
	if hedef_harita_yolu == "":
			print("Hata: Hedef sahne yolu girilmemiş!")
	Global.entrance_name = door_id 
	if Global.soul_fragments_collected >= required_fragments:
		TransitionScreen.transition_to(hedef_harita_yolu) 
	else:# Oyuncuya henüz hazır olmadığını söyleyen bir diyalog çıkar
		#DialogueBox.show_text("Henüz tüm parçalarımı bulamadım. Kendimi çok ağır hissediyorum...")
		var player = get_tree().get_first_node_in_group("Player")
		if player and door_dialogue:
			player.start_dialogue(door_dialogue, "fragments")
		else:
			print("Diyalog dosyası veya oyuncu bulunamadı!")
