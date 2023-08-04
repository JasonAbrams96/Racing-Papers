extends Control


func _ready():
	BgAudio.play_sound("res://Assets/Sounds/Mission.ogg")
	Global.player_has_upgraded_car = false
	Global.reset_for_next_day()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_SettingsButton_pressed():
	$Settings.visible = true


func _on_CreditsButton_pressed():
	$Credits.visible = true


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_PlayButton_mouse_entered():
	$Hover.visible = true
	$Hover.set_position(Vector2(80, 140))


func _on_SettingsButton_mouse_entered():
	$Hover.visible = true
	$Hover.set_position(Vector2(80, 194))


func _on_CreditsButton_mouse_entered():
	$Hover.visible = true
	$Hover.set_position(Vector2(80, 248))


func _on_QuitButton_mouse_entered():
	$Hover.visible = true
	$Hover.set_position(Vector2(80, 302))


