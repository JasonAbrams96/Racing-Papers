extends Control

#	Link Buttons to websites where I found assets
func _on_LinkButton_pressed():
	OS.shell_open("https://youtu.be/5OALyrDiObA")


func _on_lbl3Link_pressed():
	OS.shell_open("https://lunalucid.itch.io/free-creative-commons-bgm-collection")


func _on_lbl4Link_pressed():
	OS.shell_open("https://nox-sound.itch.io/essentials-series-sfx-nox-sound")

func _on_lbl5Link_pressed():
	OS.shell_open("https://opengameart.org/users/chasersgaming")


func _on_HomeBtn_pressed():
	visible = false
