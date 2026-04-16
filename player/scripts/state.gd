class_name State extends Node

static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#player bu state'e girince ne oluyor?
func Enter() -> void:
	pass
	
#player bu state'ten çıkınca ne oluyor?
func Exit()-> void:
	pass


#_process update'inde ne oluyor?
func Process(_delta : float)-> State:
	return null
	

#_physics_process update'inde ne oluyor?
func Physics(_delta : float)-> State:
	return null


#Bu state'de Input eventleriyle ne oluyor?
func HandleInput(_delta : InputEvent)-> State:
	return null
