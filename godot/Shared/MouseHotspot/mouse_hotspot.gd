extends Panel


signal is_pressed
signal entered
signal exited
var is_on := false

func _on_HotspotButton_pressed():
	SoundController.pub_play_effect("res://Shared/press.ogg",2)
	emit_signal("is_pressed")
	

func _on_HotspotButton_mouse_entered():
	if not is_on:
		is_on = true
		emit_signal("entered")
		SoundController.pub_play_effect("res://Shared/MouseHotspot/hotspot_hover.ogg",1)


func _on_HotspotButton_mouse_exited():
	if is_on:
		is_on = false
		emit_signal("exited")
		SoundController.pub_play_effect("res://Shared/unhover.ogg", 1)
