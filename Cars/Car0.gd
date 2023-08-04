extends Sprite

var car_details = {
	"top_speed" : 1000,
	"transmission":400.0,	#speed
	"engine":10.0,	#fuel efficiency
	"tires":205.0	#Best tire of the average of both
}


func _ready():
	if Global.player_car_details == null:
		Global.player_car_details = car_details


func play_animation(anim):
	if anim == "move":
		$AnimationPlayer.play("Move")
	elif anim == "stop":
		$AnimationPlayer.stop()
