extends TextureButton

signal got_pressed(value)


func _on_ButtonPrefap_pressed():
	emit_signal("got_pressed",pressed)
