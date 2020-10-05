extends TextureRect


export(String,"AND","XOR","OR", "NONE") var type := "NONE"
signal got_changed(is_active)
onready var and_animation := $AND
onready var xor_animation := $XOR
onready var or_animation := $OR
var is_active := true setget set_is_active
var port_one_active := false
var port_two_active := false
export(bool) var port_one_negated := false
export(bool) var port_two_negated := false


func _ready():
	yield(get_tree(), "idle_frame")
	set_anim_type()
	test_if_active()

func set_is_active(value):
	emit_signal("got_changed",value)
	is_active = value
	play_anim()

func disable_animation():
	and_animation.hide()
	xor_animation.hide()
	or_animation.hide()

func set_anim_type():
	disable_animation()
	if type == "AND":
		and_animation.show()
	elif type == "XOR":
		xor_animation.show()
	elif type == "OR":
		or_animation.show()

func play_anim():
	and_animation.play("default",not is_active)
	or_animation.play("default",not is_active)
	xor_animation.play("default",not is_active)

func set_active(value):
	if value != is_active:
		self.is_active = value

func test_if_active():
	if type == "AND":
		if (port_one_active) and (port_two_active):
			set_active(true)
			return
	elif type == "XOR":
		if (port_one_active or port_two_active) and not (port_one_active and port_two_active):
			set_active(true)
			return
	elif type == "OR":
		if (port_one_active or port_two_active) and not (port_one_active and port_two_active):
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

func _on_Button1_got_pressed(value):
	port_one_active = port_negation_managment(0,value)
	test_if_active()


func _on_Button2_got_pressed(value):
	port_two_active = port_negation_managment(1,value)
	test_if_active()


func _on_Button3_got_pressed(value):
	port_one_active = port_negation_managment(0,value)
	test_if_active()


func _on_Button4_got_pressed(value):
	port_two_active = port_negation_managment(1,value)
	test_if_active()


func _on_OR_animation_finished():
	or_animation.stop()
	if not is_active:
		or_animation.set_frame(0)
	else:
		or_animation.set_frame(30)


func _on_XOR_animation_finished():
	xor_animation.stop()
	if not is_active:
		xor_animation.set_frame(0)
	else:
		xor_animation.set_frame(30)


func _on_AND_animation_finished():
	and_animation.stop()
	if not is_active:
		and_animation.set_frame(0)
	else:
		and_animation.set_frame(30)
