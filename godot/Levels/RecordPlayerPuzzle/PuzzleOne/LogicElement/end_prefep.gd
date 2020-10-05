extends TextureRect


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
	if port_one_active and port_two_active:
		self.is_active = true
		return
	self.is_active = false


func _on_MidXor_got_changed(is_active):
	port_one_active = is_active
	test_if_active()


func _on_MidAnd_got_changed(is_active):
	port_two_active = is_active
	test_if_active()
