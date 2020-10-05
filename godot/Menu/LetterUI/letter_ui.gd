extends Control

onready var animation_player = $AnimationPlayer
onready var tween = $Tween
onready var inbox_notification = $"Control/VBoxContainer/InboxNotification"

export var trans_type = Tween.TRANS_BOUNCE
export(float) var notification_scaling_time = 0.3
export(Vector2) var notifaction_max_scale = Vector2(1.02, 1.02)
export(Vector2) var notifaction_min_scale = Vector2(0.98, 0.98)

var stretched := false

func _ready():
	tween.interpolate_property(inbox_notification, ":rect_scale", null, notifaction_max_scale, notification_scaling_time, trans_type)
	tween.interpolate_property(self, "stretched", false, true, notification_scaling_time)
	tween.start()

func show_inbox_notification():
	pass

func show_centered_letter(letter_name: String):
	pass


func _on_Tween_tween_completed(object, key):
	print("key ", key)
	if object == inbox_notification and key == ":rect_scale":
		if stretched:
			tween.interpolate_property(inbox_notification, "rect_scale", null, notifaction_min_scale, notification_scaling_time, trans_type)
			tween.interpolate_property(self, "stretched", true, false, notification_scaling_time)
		else:
			tween.interpolate_property(inbox_notification, ":rect_scale", null, notifaction_max_scale, notification_scaling_time, trans_type)
			tween.interpolate_property(self, "stretched", false, true, notification_scaling_time)
		tween.start()
