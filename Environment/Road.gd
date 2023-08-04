extends Node2D

var my_rng = Global.the_rng
onready var positions = $Positions.get_children()
var position_count = 0
var can_delete = true
export var is_blank_road = false

func _ready():
	if !is_blank_road:
		while(position_count < positions.size()):
			if Global.road_postion_count == 0:
				#Create something
				var choice = Global.the_rng.randi() % Global.road_creations.size()
				if choice == 0:
					choice = "trailer"
				elif choice == 1:
					choice = "house"
				elif choice == 2:
					choice = "stop"
				elif choice == 3:
					choice = "stop_camera"
				elif choice == 4:
					choice = "fuel"
				elif choice == 5:
					choice = "news"
					
				if Global.road_previous_created == "stop" or Global.road_previous_created =="stop_camera":
					choice = "trailer"
				var creation = Global.road_creations[choice].instance()
				creation.global_position = positions[position_count].global_position
				add_child(creation)
				Global.road_postion_count = Global.road_creations_width[choice]
				Global.road_previous_created = choice
			else:
				Global.road_postion_count -= 1
			position_count += 1
			

func set_delete():
	can_delete = !can_delete
	
func _on_VisibilityNotifier2D_screen_exited():
	if can_delete:
		queue_free()
