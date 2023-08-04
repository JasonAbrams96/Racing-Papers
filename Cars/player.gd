extends KinematicBody2D

export var player_num = 0
export var is_active = true#USed to swap between cars
var motion = Vector2()
var my_car = null
var not_showing_need_papers = true
var in_deliverable_area = null

var engine_on = false
var braking = true

func _ready():
	Global.player_can_move = true
	Global.connect("fuel_updated", self, "got_fuel")
	Global.connect("fuel_empty", self, "no_fuel")
	var car = null
	if Global.player_has_upgraded_car:
		car = load("res://Cars/Car0_b.tscn").instance()
	else:
		car = load("res://Cars/Car0_a.tscn").instance()
	add_child(car)
	my_car = car
	Global.play_sfx("res://Assets/Sounds/EngineStart.wav", self)
	
func get_input():
	if Input.is_action_pressed("left"):
		motion.x -= Global.player_car_details["transmission"]
		if motion.x <= 0:
			motion.x = 0
			my_car.play_animation("stop")
			if braking:
				braking = false
				Global.play_sfx("res://Assets/Sounds/Brake.wav", self)
				
	elif Input.is_action_pressed("right"):
		engine_on = true
		braking = false
		motion.x += Global.player_car_details["transmission"]
		if motion.x >= Global.player_car_details["top_speed"]:
			motion.x = Global.player_car_details["top_speed"]
		my_car.play_animation("move")
	else:
		if motion.x > 0:
			motion.x -= 50
		else:
			motion.x = 0
			my_car.play_animation("stop")
			if engine_on:
				Global.play_sfx("res://Assets/Sounds/EngineStop.wav", self)
				engine_on = false
	# Player can throw papers at nothing but also houses
	if Input.is_action_just_pressed("deliver") and is_active:
		if in_deliverable_area and Global.player_newspapers > 0:
			in_deliverable_area.delivered()
			in_deliverable_area = null
			Global.emit_signal("newspaper_thrown", -1)
		elif not_showing_need_papers and Global.player_newspapers <= 0:
			not_showing_need_papers = false
			var child = load("res://Menus/NeedPapers.tscn").instance()

			child.rect_position.x = -128
			child.rect_position.y = -272
			
			add_child(child)
		Global.play_sfx("res://Assets/Sounds/Newspaper Throw.wav", self)
			
	if is_active and Input.is_action_just_pressed("Honk"):
		Global.play_sfx("res://Assets/Sounds/Honk.wav", self)
		
func _physics_process(delta):
	if Global.player_can_move:
		get_input()
		motion = move_and_slide(motion)

		if is_active:
			Global.player_fuel_count += 1
			if Global.player_fuel_count == Global.player_fuel_count_max:
				Global.player_fuel_count = 0
				#	an algorithm that I am trying used to find how much fuel is used a tick
				var fuel_taken_away = (Global.player_car_details["engine"] *
										 Global.player_car_details["transmission"] / 
										Global.player_car_details["tires"])
										
				Global.emit_signal("fuel_updated", fuel_taken_away)
	else:
		motion.x -= 25
		move_and_slide(motion)
		if motion.x <= 0 :
			set_physics_process(false)
			
func set_active():
	is_active = !is_active

func no_fuel():
	my_car.play_animation("stop")

func got_fuel(temp):
	Global.player_fuel_count = 0
	

