extends Node2D


signal is_active

func _on_EndPrefep_got_changed(is_active):
	if is_active:
		emit_signal("is_active")
