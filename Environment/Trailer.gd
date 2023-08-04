extends Area2D


var score = 1 #Money to give to player
var livered = false
var in_area = false

func _ready():
	#Choose which color traier to use

	var choice = Global.the_rng.randi() % 3
	if choice == 1:
		$Sprite.frame = 1
	elif choice == 2:
		$Sprite.frame = 2

func _on_Trailer_body_entered(body):
	if body and !livered:
		body.in_deliverable_area = self


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Trailer_body_exited(body):
	if body:
		body.in_deliverable_area = null

func delivered():
	if !livered:
		livered = true
		Global.player_money += score
		Global.num_of_deliveries += 1
		Global.total_deliveries += 1
		$Sprite2.visible = true
