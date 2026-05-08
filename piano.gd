# piano.gd veya npc.gd gibi bir nesneye bağla
extends StaticBody2D

# Editörden oluşturduğun .dialogue dosyasını buraya sürükleyip bırakacaksın
@export var my_dialogue_resource: DialogueResource 
@export var dialogue_start_title: String = "start"

func trigger_inspect():
	print(	"interacted")
	# Oyuncu 'E'ye bastığında bu fonksiyon çalışacak
	if my_dialogue_resource:
		print("dialogue found")
		# Oyuncuyu bul ve diyaloğu başlat fonksiyonunu çağır
		var player = get_tree().get_first_node_in_group("Player")
		if player:
			print("player found, dialogue started")
			player.start_dialogue(my_dialogue_resource, dialogue_start_title)
