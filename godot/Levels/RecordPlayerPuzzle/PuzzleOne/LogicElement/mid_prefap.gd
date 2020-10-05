extends TextureRect


export(String,"AND","XOR", "NONE") var type := "NONE"
signal got_changed(is_active)
var is_active := false setget set_is_active
var port_one_active := false
var port_two_active := false
export(String, FILE) var off_texture
export(String, FILE) var on_texture


func set_is_active(value):
	emit_signal("got_changed",value)
	if value:
		self.set_texture(load(on_texture))
	else:
		self.set_texture(load(off_texture))
	is_active = value

func test_if_active():
	if type == "AND":
		if (port_one_active) and (port_two_active):
			self.is_active = true
			return
	elif type == "XOR":
		if (port_one_active or port_two_active) and not (port_one_active and port_two_active):
			self.is_active = true
			return
	self.is_active = false

func _on_Button1_got_pressed(value):
	port_one_active = value
	test_if_active()


func _on_Button2_got_pressed(value):
	port_two_active = value
	test_if_active()


func _on_Button3_got_pressed(value):
	port_one_active = value
	test_if_active()


func _on_Button4_got_pressed(value):
	port_two_active = not value
	test_if_active()
