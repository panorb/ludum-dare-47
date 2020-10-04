extends Sprite


var down_time := randi()%6+20.0
var playback_speed := 128.0

func _ready():
	get_child(0).play("NeedleRotation",1,randi()%3+3)
	
func calculate_down_time():
	if playback_speed == 0:
		return 42 #arbitary number
	return (randi()%6+20)*128.0/(playback_speed)

func update_playback_speed(value):
	playback_speed = value	
	down_time = calculate_down_time()

func _physics_process(delta):
	down_time-=(playback_speed)*delta
	down_time=clamp(down_time,0,42)
	if not get_node("AnimationPlayer").is_playing() and down_time == 0:
		get_node("AnimationPlayer").play("NeedleRotation",1,randi()%3+3)
		down_time = calculate_down_time()
