extends Sprite


var car_details = {
	"top_speed" : 1600,
	"transmission":910.0,	#speed
	"engine":1.0,	#fuel efficiency
	"tires":455.5	#Best tire of the average of both
}


func _ready():
	if Global.player_has_upgraded_car:
		Global.player_car_details = car_details

func play_animation(anim):
	if anim == "move":
		$AnimationPlayer.play("Move")
	elif anim == "stop":
		$AnimationPlayer.stop()
