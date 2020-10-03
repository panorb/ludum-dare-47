extends Sprite

var down_time = randi()%6+20

func _ready():
	get_child(0).play("NeedleRotation",1,randi()%3+3)
	
func _physics_process(delta):
	down_time-=1
	down_time=clamp(down_time,0,42)
	if not get_child(0).is_playing() and down_time == 0:
		get_child(0).play("NeedleRotation",1,randi()%3+3)
		down_time = randi()%6+20
