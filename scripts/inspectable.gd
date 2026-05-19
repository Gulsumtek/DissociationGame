# inspectable.gd
extends StaticBody2D
@export var soul_dialogue: DialogueResource  # Ruh modunda çıkacak diyalog
@export var inspect_text: String = "Buraya inceleme metnini yaz."
@export var inspect_dialogue: DialogueResource
@export var gives_fragment: bool = false  # Inspector'dan seç
@export var fragment_reward: int = 1
var interacted: bool = false
var soul_interacted: bool = false  # bunu ekle
func trigger_inspect():
	var player = get_tree().get_first_node_in_group("Player")
	if not player:
		return
		
	# Soul modda farklı diyalog/davranış
	if player.is_soul_mode:
		if soul_interacted:
			return
		soul_interacted = true
		player.drop_soul_fragment()
		Global.soul_fragments_dropped += 1
		print("Fragment düşürüldü! Toplam: ", Global.soul_fragments_dropped)
		if soul_dialogue:
			player.start_dialogue(soul_dialogue, "start")
		return
	# Beden modu
	if interacted and gives_fragment:
		return
	if inspect_dialogue:
		if gives_fragment:
			interacted = true
		player.start_dialogue(inspect_dialogue, "start")
		if gives_fragment:
			player.dialogue_finished.connect(_on_dialogue_finished, CONNECT_ONE_SHOT)
	else:
		DialogueBox.show_text(inspect_text)

func _on_dialogue_finished():
	Global.soul_fragments_collected += fragment_reward
	SoundManager.play_collect()
	print("Fragment verildi! Toplam: ", Global.soul_fragments_collected)
