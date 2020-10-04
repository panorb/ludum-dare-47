extends Sprite

export(float,0,50.0) var playback_speed := 2.0

func update_playback_speed(value):
	playback_speed = (value/64.0)

func _process(delta):
	rotate(delta*playback_speed)
