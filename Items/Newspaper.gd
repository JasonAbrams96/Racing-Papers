extends Area2D

var amount = 3





func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Newspaper_body_entered(body):
	if body:
		Global.player_newspapers += amount
		Global.emit_signal("newspaper_got")
		queue_free()
