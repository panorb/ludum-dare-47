extends Sprite


var down_time := randi()%6+20.0
var playback_speed := 128.0
var is_playing := false
var is_returning := false
var animation_time := randi()%3+3.0
var total_rot := 0.0

func _ready():
	pass
	
func calculate_down_time():
	if playback_speed == 0:
		return 42 #arbitary number
	return (randi()%6+20)*128.0/(playback_speed)

func update_playback_speed(value):
	playback_speed = value	
	down_time = calculate_down_time()

func initalize_animation():
	animation_time = randi()%3+3.0 *128.0/(playback_speed+0.1)
	pass

func _physics_process(delta):
	if down_time == 0:
		if not is_playing:
			is_playing = true
			initalize_animation()
		if is_playing:
			animation_time-=delta*10
			animation_time=clamp(animation_time,0,42)
			var current_rot = clamp(delta*playback_speed/42000.0,0,20)
			rotate(current_rot)
			total_rot += current_rot
		if animation_time == 0:
			is_returning = true
		if is_returning:
			var return_speed = playback_speed * delta / 10
			var rest_speed = total_rot - return_speed
			if rest_speed < 0.0:
				return_speed += rest_speed
			rotate(-return_speed)
			total_rot=clamp(rest_speed,0,42)			
			if total_rot == 0:	
				down_time = calculate_down_time()
				rotate(-total_rot)
				is_returning = false
				is_playing = false
	else:
		down_time-=(playback_speed)*delta
		down_time=clamp(down_time,0,42)
