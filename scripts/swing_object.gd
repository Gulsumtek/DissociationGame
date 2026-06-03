extends StaticBody2D

@export var cutscene_path: String = ""
@export var only_soul_mode: bool = true

var already_triggered: bool = false

func _ready():
	var interaction_area = $InteractionArea
	interaction_area.interact.connect(trigger_inspect)
	
	if only_soul_mode:
		interaction_area.visible = false

func _process(_delta):
	if not only_soul_mode:
		return
	
	var player = get_tree().get_first_node_in_group("Player")
	if player == null:
		return
	
	$InteractionArea.visible = player.is_soul_mode

func trigger_inspect():
	if already_triggered:
		return
	
	var player = get_tree().get_first_node_in_group("Player")
	if player == null:
		return
	
	if only_soul_mode and not player.is_soul_mode:
		return
	
	if cutscene_path == "":
		print("Hata: cutscene_path boş!")
		return
	
	already_triggered = true
	_trigger_cutscene(player)

func _trigger_cutscene(player):
	player.is_frozen = true
	await TransitionScreen.fade_out()
	TransitionScreen.transition_to(cutscene_path)
