extends Area2D

var in_area = false
var livered = false
var score = 2 #Money that the player gets

func _ready():
	var choice = Global.the_rng.randi() % 3
	if choice == 1:
		$Sprite.frame = 1
	elif choice == 2:
		$Sprite.frame = 2

func _on_House_body_entered(body):
	if body:
		body.in_deliverable_area = self


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_House_body_exited(body):
	if body:
		body.in_deliverable_area = null

func delivered():
	if !livered:
		livered = true
		Global.num_of_deliveries += 1
		Global.total_deliveries += 1
		Global.player_money += score
		$Sprite2.visible = true
	
