extends CanvasLayer


onready var deco_wheel1 = $DecoWheels/DecoWheel1
onready var deco_wheel2 = $DecoWheels/DecoWheel2
onready var deco_wheel3 = $DecoWheels/DecoWheel3
signal is_active

func _on_MidXor_got_changed(is_active):
	if is_active:
		deco_wheel1.rotation_speed = 0.8
	else:
		deco_wheel1.rotation_speed = 0.0


func _on_MidAnd_got_changed(is_active):
	if is_active:
		deco_wheel2.rotation_speed = -1.6
	else:
		deco_wheel2.rotation_speed = 0.0


func _on_EndPrefep_got_changed(is_active):
	if is_active:
		deco_wheel3.rotation_speed = 2.4
		emit_signal("is_active")
	else:
		deco_wheel3.rotation_speed = 0.0

