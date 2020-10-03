extends VBoxContainer


export var val=3 
signal was_changed

func _ready():
	update_text()
	
func update_text() ->void:
	get_child(1).set_text(str(val))
	emit_signal("was_changed")

func _on_Up_pressed():
	val+=1
	val = clamp(val,0.0,9.0)
	update_text()
	
func _on_Down_pressed():
	val-=1
	val = clamp(val,0.0,9.0)
	update_text()
