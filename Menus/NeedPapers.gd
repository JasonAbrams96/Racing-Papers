extends Label

var time = 0

func _process(delta):
	if time == 300:
		get_parent().not_showing_need_papers = true
		queue_free()
	else:
		time += 1
