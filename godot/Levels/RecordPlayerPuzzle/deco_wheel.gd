extends Sprite


export(float, -3.0,3.0) var rotation_speed := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(delta*rotation_speed)
