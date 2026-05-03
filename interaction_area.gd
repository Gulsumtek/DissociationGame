# interaction_area.gd
extends Area2D

signal interact # Etkileşim gerçekleştiğinde yayılacak sinyal

@onready var prompt = $PromptPosition

func _ready():
	prompt.hide()
	# Sinyalleri kodla bağlayalım (Editörden tek tek uğraşmamak için)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area.name == "InteractionDetector" or area.get_parent().is_in_group("Player"):
	# En güvenli yöntem: Eğer giren alanın adı InteractionDetector ise göster
		prompt.show()

func _on_area_exited(area):
	if area.name == "InteractionDetector" or area.get_parent().is_in_group("Player"):
		prompt.hide()

# Karakter 'E'ye bastığında bu fonksiyonu çağıracağız
func trigger_interact():
	interact.emit()
