extends AudioStreamPlayer

func _ready():
	finished.connect(_on_finished)

func _on_finished():
	play()  # Bitince tekrar çal, randomizer yeni şarkı seçer
