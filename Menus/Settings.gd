extends Control

func zero_volume(name):
	Global.change_volume(AudioServer.get_bus_index(name), -80.0)

func _ready():
	$ColorRect/Master/MasterSlider.value = AudioServer.get_bus_volume_db(0)
	$ColorRect/SFX/SFXSLider.value = AudioServer.get_bus_volume_db(1)
	$ColorRect/SFX2/MusicSlider.value = AudioServer.get_bus_volume_db(2)


func _on_MasterSlider_value_changed(value):
	if value == -20.0:
		zero_volume("Master")
	else:
		Global.change_volume(AudioServer.get_bus_index("Master"), value)
		


func _on_SFXSLider_value_changed(value):
	if value == -20.0:
		zero_volume("SFX")
	else:
		Global.change_volume(AudioServer.get_bus_index("SFX"), value)


func _on_MusicSlider_value_changed(value):
	if value == -20.0:
		zero_volume("Music")
	else:
		Global.change_volume(AudioServer.get_bus_index("Music"), value)


func _on_HomeBtn_pressed():
	visible = false
