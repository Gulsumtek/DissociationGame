extends Area2D

@export_file("*.tscn") var hedef_harita_yolu: String
@export var door_id : String # Bu kapının benzersiz adı
@export var required_fragments: int # Bu kapı için gereken parça sayısı
@export var door_dialogue: DialogueResource

func _on_body_entered(body):
	if body.name == "Player": # Karakterinin adı Player ise
		if hedef_harita_yolu == "":
				print("Hata: Hedef sahne yolu girilmemiş!") 
		if Global.soul_fragments_collected >= required_fragments:
			TransitionScreen.transition_to(hedef_harita_yolu) 
