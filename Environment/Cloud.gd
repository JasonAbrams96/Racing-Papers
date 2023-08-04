extends Node2D

func _ready():
	var choice = Global.the_rng.randi() % 5
	
	var cloud = "cloud"  + String(choice + 1)
	$Sprite.texture = load("res://Assets/" + cloud + ".png")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
