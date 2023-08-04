extends Node

signal fuel_updated(fuel_difference)
signal fuel_empty
signal player_cited
signal newspaper_thrown
signal newspaper_got
#signal money_updated

var the_rng = RandomNumberGenerator.new()
var road_width = 998

var player_car_details = null

var player = null
var player_can_move = true
var player_money = 0
var player_total_money = 0
var player_fuel = 100.0
var player_fuel_count = 0
var player_fuel_count_max = 120
var player_newspapers = 10
var num_of_citations = 0
var num_of_deliveries = 0 
var total_citations = 0
var total_deliveries = 0
var total_days = 0
var good_player_bonus = 0
var upgrade_transmission = 5
var upgrade_engine = 7
var transmission_price = 10
var engine_price = 10
var player_has_upgraded_car = false

var road_previous_created = null
var road_creations_width = {"trailer" : 2,
					"house": 2,
					"stop": 1,
					"stop_camera" : 1,
					"fuel": 0,
					"news": 0,}
var road_postion_count = 0
var road_creations = {
	"trailer": preload("res://Environment/Trailer.tscn"),
	"house": preload("res://Environment/House.tscn"),
	"stop": preload("res://Enemies/StopSign.tscn"),
	"stop_camera": preload("res://Enemies/StopSign_withCamera.tscn"),
	"fuel": preload("res://Items/Fuel.tscn"),
	"news": preload("res://Items/Newspaper.tscn"),
}

var sfx_player = preload("res://Audio/SFXAudio.tscn")

func play_sfx(sfx_location, scene):
	var audio = load(sfx_location)
	var my_sfx = sfx_player.instance()
	scene.add_child(my_sfx)
	my_sfx.play_sound(audio)

func change_volume(audio_channel, value):
	AudioServer.set_bus_volume_db(audio_channel, value)
	
func reset_for_next_day():
	player_fuel = 100.0
	player_fuel_count = 0
	player_newspapers = 10
	num_of_citations = 0
	num_of_deliveries = 0
	player_can_move = true
	player_money = 0


func upgrade_transmissio():
	player_car_details["transmission"] += 70
	player_car_details["top_speed"] += 50
	upgrade_tires()
	
func upgrade_engin():
	player_car_details["engine"] -= 1
	upgrade_tires()
	
func upgrade_tires():
	player_car_details["tires"] = (player_car_details["transmission"] + player_car_details["engine"]) / 2
