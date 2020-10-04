extends Control

func _ready():
	print("Sprite entered the scene!")
	get_node(".").visible = false
	print("Sprite is invisible!")
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	get_node(".").visible = true
	print("Sprite is visible!")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)) and get_node(".").visible:
			print("Click on letter sprite!")
			position = Vector2(1920.0, 1080.0)
			scale = Vector2(3.0, 3.0)
			get_child(0).rect_size = Vector2(1878.0, 1878.0)
			get_child(0).text = load_file("res://Levels/RecordPlayerFront/Letters/IntroLetter.txt")

func load_file(file):
	var f = File.new()
	f.open(file, File.READ)
	var line = ""
	while not f.eof_reached():
		line += f.get_line() + "\n"
	f.close()
	return line
