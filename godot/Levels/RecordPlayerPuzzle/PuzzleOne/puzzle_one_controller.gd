extends Node2D


onready var mouse_hotspot = $MouseHotspot
signal done

func _ready():
	mouse_hotspot.hide()



func _on_RecordPlayerPuzzleOne_is_active():
	mouse_hotspot.show()


func _on_MouseHotspot_is_pressed():
	mouse_hotspot.hide()
	emit_signal("done")	
	
