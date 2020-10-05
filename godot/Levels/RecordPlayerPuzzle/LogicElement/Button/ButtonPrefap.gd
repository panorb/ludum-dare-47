extends TextureButton

signal got_pressed(value)
signal forced_press(value)
onready var animated_sprite = $AnimatedSprite

func _ready():
	yield(get_tree(), "idle_frame")
	emit_signal("got_pressed",pressed)

func play_animation():
	animated_sprite.play("default",pressed)

func force_update():
	emit_signal("forced_press",pressed)
	animated_sprite.play("default",pressed)

func _on_ButtonPrefap_pressed():
	play_animation()
	SoundController.pub_play_effect("res://Levels/RecordPlayerPuzzle/LogicElement/Button/LogicButtonPress.wav",3)
	emit_signal("got_pressed",pressed)

func _on_AnimatedSprite_animation_finished():
	animated_sprite.stop()
	if pressed:
		animated_sprite.set_frame(0)
	else:
		animated_sprite.set_frame(30)
