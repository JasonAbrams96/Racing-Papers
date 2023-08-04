extends CanvasLayer


onready var fuel_bar = $Control/Panel/ProgressBar
onready var paper_amount_lbl = $Control/Panel/NewsTexture/Label


func _ready():
	Global.connect("fuel_updated", self, "update_fuel_bar")
	Global.connect("newspaper_thrown", self, "update_newspaper_label")
	
	
func update_fuel_bar(value_to_minus):
	fuel_bar.value -= value_to_minus
	
	if fuel_bar.value <= 0:
		Global.player_can_move = false
		Global.emit_signal("fuel_empty")
	elif fuel_bar.value > 0 and Global.player_can_move == false :
		Global.player_can_move = true

func update_newspaper_label(num_of_paper):
	Global.player_newspapers += num_of_paper
	if Global.player_newspapers <= 0:
		Global.player_newspapers = 0
	paper_amount_lbl.text = "x " + String(Global.player_newspapers)


func _on_HomeBtn_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")
