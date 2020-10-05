extends TextureRect


signal got_changed(is_active)
var is_active := true setget set_is_active
var port_one_active := false
var port_two_active := false
export(bool) var port_one_negated := false
export(bool) var port_two_negated := false
onready var animated_sprite := $AnimatedSprite

func _ready():
	yield(get_tree(), "idle_frame")
	test_if_active()

func set_active(value):
	if value != is_active:
		self.is_active = value


func set_is_active(value):
	emit_signal("got_changed",value)
	is_active = value
	animated_sprite.play("default", not is_active)

func test_if_active():
	if port_one_active and port_two_active:
		set_active(true)
		return
	set_active(false)

func port_negation_managment(port_idx:int,value:bool) -> bool:
	if port_idx == 0:
		if port_one_negated:
			return not value
		return value
	if port_idx == 1:
		if port_two_negated:
			return not value
		return value
	return false

func _on_MidXor_got_changed(is_active):
	port_one_active = port_negation_managment(0,is_active)
	test_if_active()

func _on_MidAnd_got_changed(is_active):
	port_two_active = port_negation_managment(1,is_active)
	test_if_active()

func _on_AnimatedSprite_animation_finished():
	animated_sprite.stop()
	if not is_active:
		animated_sprite.set_frame(0)
	else:
		animated_sprite.set_frame(30)
