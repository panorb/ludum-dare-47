extends CanvasLayer


onready var mouse_hotspot = $MouseHotspot

export(Array, String, FILE) var loadable_textures : Array = []

func _ready():
	mouse_hotspot.hide()



func _on_RecordPlayerPuzzleOne_is_active():
	mouse_hotspot.show()


func _on_MouseHotspot_is_pressed():
	print("next_level")
	mouse_hotspot.hide()
