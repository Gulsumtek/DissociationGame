# dialogue_box.gd
extends CanvasLayer

@onready var label = $Panel/Label
@onready var panel = $Panel

var is_typing: bool = false
var current_tween: Tween

func show_text(text: String):
	show() # CanvasLayer'ı göster
	panel.show()
	label.text = text
	label.visible_ratio = 0.0
	is_typing = true
	
	if current_tween: current_tween.kill() # Varsa eski animasyonu durdur
	current_tween = create_tween()
	var duration = text.length() * 0.03
	current_tween.tween_property(label, "visible_ratio", 1.0, duration)
	current_tween.finished.connect(func(): is_typing = false)

func skip_typing():
	if current_tween: current_tween.kill()
	label.visible_ratio = 1.0
	is_typing = false

func close():
	panel.hide()
	hide() # CanvasLayer'ı gizle
	is_typing = false
	hide()
