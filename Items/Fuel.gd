extends Area2D


var fuel_amount = 10.0



func _on_Area2D_body_entered(body):
	if body:
		Global.player_fuel += fuel_amount
		if Global.player_fuel >= 100.0:
			Global.player_fuel = 100.0
			
		if !Global.player.is_active:
			Global.player.is_active = true
		Global.emit_signal("fuel_updated", -fuel_amount) # it is a minus amount to add to the GUI value
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
