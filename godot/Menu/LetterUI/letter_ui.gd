extends Control

onready var animation_player := $AnimationPlayer
onready var tween := $Tween
onready var inbox_notification := $Notification/InboxNotification
onready var mouse_hotspot = $MouseHotspot

export var trans_type = Tween.TRANS_CIRC
export(float) var notification_scaling_time := 0.3
export(Vector2) var notifaction_max_scale := Vector2(1.02, 1.02)
export(Vector2) var notifaction_min_scale := Vector2(0.98, 0.98)

var stretched := false

export(Array, String, FILE, "*.txt") var available_letters = []
var current_letter_idx := 0

onready var letter = $CenterView/Letter

func show_inbox_notification():
	inbox_notification.visible = true
	mouse_hotspot.visible = true
	tween.interpolate_property(inbox_notification, ":rect_scale", Vector2(0.01, 0.01), notifaction_min_scale, 3*notification_scaling_time, trans_type)
	tween.start()

func show_centered_letter():
	letter.visible = true
	var current_letter : String = LetterTexts.LETTERS[current_letter_idx]
	letter.letter_text = current_letter
	
	current_letter_idx += 1

func _on_Tween_tween_completed(object, key):
	if object == inbox_notification and key == ":rect_scale":
		if inbox_notification.rect_scale == notifaction_min_scale:
			tween.interpolate_property(inbox_notification, ":rect_scale", null, notifaction_max_scale, notification_scaling_time, trans_type)
		else:
			tween.interpolate_property(inbox_notification, "rect_scale", null, notifaction_min_scale, notification_scaling_time, trans_type)


func _on_MouseHotspot_entered():
	inbox_notification.modulate = Color("#963341")


func _on_MouseHotspot_exited():
	inbox_notification.modulate = Color.white


func _on_MouseHotspot_is_pressed():
	show_centered_letter()
