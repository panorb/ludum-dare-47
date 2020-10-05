extends CanvasLayer

onready var buttons = $RecordPlayerPuzzleThree/Buttons.get_children()
onready var mouse_hotspot = $MouseHotspot


func _ready():
	mouse_hotspot.hide()


func _on_MouseHotspot_is_pressed():
	print("next_level")
	mouse_hotspot.hide()


func _on_RecordPlayerPuzzleTwo_is_active():
	mouse_hotspot.show()


func _on_ButtonOne_pressed():
	buttons[1].pressed = not buttons[1].pressed
	buttons[1].force_update()


func _on_ButtonTwo_pressed():
	buttons[2].pressed = not buttons[2].pressed
	buttons[2].force_update()


func _on_ButtonThree_pressed():
	buttons[3].pressed = not buttons[3].pressed
	buttons[3].force_update()
	
func _on_ButtonFour_pressed():
	buttons[0].pressed = not buttons[0].pressed
	buttons[0].force_update()
	
