extends StaticBody2D

@export var inspect_text: String = "Buraya inceleme metnini yaz."
@export var dialogue: DialogueResource

func trigger_inspect():
	print("show_text çağrılıyor, metin: ", inspect_text)
	print("Buraya diyalog koy")
	#DialogueBox.show_text(inspect_text)
	print("show_text çağrıldı")
	var player = get_tree().get_first_node_in_group("Player")
	if player and dialogue:
		player.start_dialogue(dialogue, "start")
