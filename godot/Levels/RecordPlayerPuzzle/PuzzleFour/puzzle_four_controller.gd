extends CanvasLayer

onready var buttons_first_colomn = $RecordPlayerPuzzleFour/ButtonFirstRow.get_children()
onready var buttons_second_colomn = $RecordPlayerPuzzleFour/ButtonSecondRow.get_children()
onready var buttons_third_colomn = $RecordPlayerPuzzleFour/ButtonThirdRow.get_children()
onready var mouse_hotspot = $MouseHotspot


func _ready():
	mouse_hotspot.hide()

func _on_MouseHotspot_is_pressed():
	print("next_level")
	mouse_hotspot.hide()


func _on_RecordPlayerPuzzleFour_is_active():
	mouse_hotspot.show()


func _on_ButtonOne_got_pressed(value):
	buttons_first_colomn[1].pressed = not buttons_first_colomn[1].pressed
	buttons_first_colomn[1].force_update()


func _on_ButtonTwo_got_pressed(value):
	buttons_first_colomn[2].pressed = not buttons_first_colomn[2].pressed
	buttons_first_colomn[2].force_update()


func _on_ButtonThree_got_pressed(value):
	buttons_first_colomn[3].pressed = not buttons_first_colomn[3].pressed
	buttons_first_colomn[3].force_update()


func _on_ButtonFour_got_pressed(value):
	buttons_first_colomn[0].pressed = not buttons_first_colomn[0].pressed
	buttons_first_colomn[0].force_update()


func _on_ButtonSix_got_pressed(value):
	buttons_second_colomn[2].pressed = not buttons_second_colomn[2].pressed
	buttons_second_colomn[2].force_update()


func _on_ButtonEight_got_pressed(value):
	buttons_second_colomn[0].pressed = not buttons_second_colomn[0].pressed
	buttons_second_colomn[0].force_update()


func _on_ButtonTen_got_pressed(value):
	buttons_third_colomn[2].pressed = not buttons_third_colomn[2].pressed
	buttons_third_colomn[2].force_update()


func _on_ButtonEleven_got_pressed(value):
	buttons_third_colomn[3].pressed = not buttons_third_colomn[3].pressed
	buttons_third_colomn[3].force_update()

