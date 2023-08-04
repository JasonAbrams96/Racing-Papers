extends Node2D


onready var good_area = $GoodArea
onready var bad_area = $BadArea
onready var timer = $Timer

var player_in_good = false
var player_in_bad = false
var is_done = false
var good_count = 0

func _on_Timer_timeout():
	if is_done:
		timer.stop()
	else:	
		if Global.player.motion.x == 0:
			good_count += 1
			
		if good_count == 5:
			is_done = true
			$Sprite.frame = 1
			Global.good_player_bonus += 1
			timer.stop()

func _on_GoodArea_body_entered(body):
	timer.start()

func _on_BadArea_body_entered(body):
	if !is_done:
		is_done = true
		Global.emit_signal("player_cited")
		Global.num_of_citations += 1
		Global.total_citations += 1
		Global.good_player_bonus -= 1


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
