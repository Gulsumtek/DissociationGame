extends StaticBody2D

@export var inspect_text: String = "Buraya inceleme metnini yaz."

func trigger_inspect():
	print("show_text çağrılıyor, metin: ", inspect_text)
	DialogueBox.show_text(inspect_text)
	print("show_text çağrıldı")
