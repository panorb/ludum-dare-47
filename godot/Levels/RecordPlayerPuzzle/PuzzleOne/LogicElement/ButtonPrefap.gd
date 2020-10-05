extends TextureButton

signal got_pressed(value)

func _ready():
	yield(get_tree(), "idle_frame")
	emit_signal("got_pressed",pressed)

func _on_ButtonPrefap_pressed():
	emit_signal("got_pressed",pressed)
