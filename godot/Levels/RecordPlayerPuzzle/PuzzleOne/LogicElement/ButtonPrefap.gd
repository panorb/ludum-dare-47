extends TextureButton

signal got_pressed(value)
onready var animated_sprite = $AnimatedSprite

func _ready():
	yield(get_tree(), "idle_frame")
	emit_signal("got_pressed",pressed)

func _on_ButtonPrefap_pressed():
	animated_sprite.play("default",pressed)
	emit_signal("got_pressed",pressed)

func _on_AnimatedSprite_animation_finished():
	animated_sprite.stop()
	if pressed:
		animated_sprite.set_frame(0)
	else:
		animated_sprite.set_frame(30)
