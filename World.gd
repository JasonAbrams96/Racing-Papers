extends Node

var saved_roads = []

var road = preload("res://Environment/Road.tscn")
var next_position = 998
var road_load_distant = 700

var camera

func _ready():
	
	Global.player = $p1
	camera = $p1/Camera2D
	Global.connect("fuel_empty", self, "start_timer")
	
	BgAudio.play_sound("res://Assets/Sounds/POL-twin-turbo-short.ogg")

func _process(delta):

	var cloud_position = Vector2(0, Global.the_rng.randf_range(-380, -265))
	var cloud_got = Global.the_rng.randi() % 10
	#setting up new roads
	if Global.player.global_position.x > road_load_distant:
		road_load_distant += 700
		var new_road = road.instance()
		$Roads.add_child(new_road)
		new_road.global_position.x = next_position
		next_position += Global.road_width
		
		#Check to see if a cloud can be spawned in
		if cloud_got >= 7:
			var c = load("res://Environment/Cloud.tscn").instance()
			cloud_position.x = Global.player.global_position.x + 750
			c.global_position = cloud_position
			add_child(c)
			
		if saved_roads.size() == 4:
			saved_roads.pop_front()
			saved_roads.push_back(new_road)
		else:
			saved_roads.push_back(new_road)

	if Global.player.global_position.x > 100000:
		swap_player()
		
func swap_player():
	$p1.set_active()
	$p2.set_active()	
	
	if $p1.is_active:
		$p2.remove_child(camera)
		$p1.add_child(camera)
		Global.player = $p1
		$p2.global_position.x -= 200000.0
	elif $p2.is_active:
		$p1.remove_child(camera)
		$p2.add_child(camera)
		Global.player = $p2
		$p1.global_position.x -= 200000.0
		
	road_load_distant = Global.player.global_position.x + 700
	
	create_roads_for_swap()
	
func create_roads_for_swap():
	for i in saved_roads:
		i.set_delete()
		i.global_position.x -= 100000.0
		i.set_delete()
	#next_position = saved_roads[3].global_position.x + Global.road_width
	#road_load_distant = saved_roads[3].global_position.x

func start_timer():
	$Timer.start()
	
func _on_Timer_timeout():
	get_tree().change_scene("res://Menus/NextDayScreen.tscn")


func _on_HomeBtn_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")
