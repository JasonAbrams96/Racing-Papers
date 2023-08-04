extends Control


onready var tween = $Tween
var current_slide = 0
var is_playing = false
onready var control = $Control
onready var control_size = $Control.get_child_count() - 1

func _on_ArrowBtn_pressed():
	if !is_playing:
		if current_slide == control_size:
			tween.interpolate_property(control, "rect_position", control.rect_position, Vector2(0, control.rect_position.y), 1.0, Tween.TRANS_LINEAR )
			current_slide = 0
		else:
			tween.interpolate_property(control, "rect_position", control.rect_position, Vector2(control.rect_position.x - 297, control.rect_position.y), 1.0, Tween.TRANS_LINEAR )
			current_slide += 1
		is_playing = true
		tween.start()

func _on_Tween_tween_all_completed():
	tween.stop_all()
	is_playing = false
