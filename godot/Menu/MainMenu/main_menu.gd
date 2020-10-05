extends Control

onready var letter_timer := $LetterTimer
onready var letter_ui := $CanvasLayer/LetterUI
onready var full_screen_hospot := $FullScreenHotspot
onready var video_player := $VideoPlayer
onready var button_container := $CanvasLayer/HBoxContainer
onready var _tween = $Tween

onready var play_button = $CanvasLayer/HBoxContainer/VBoxContainer/PlayButton
onready var volume_button = $CanvasLayer/HBoxContainer/VBoxContainer/VolumeButton
onready var exit_button = $CanvasLayer/HBoxContainer/VBoxContainer/ExitButton

func _on_LetterTimer_timeout():
	letter_ui.show_inbox_notification()

func _on_LetterUI_letter_unfocused():
	video_player.play()
	yield(get_tree().create_timer(0.1), "timeout")
	video_player.visible = true

func _on_VideoPlayer_finished():
	print("_on_VideoPlayer_finished")
	_tween.interpolate_property(button_container, ":modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 2, Tween.TRANS_SINE)
	_tween.start()


func _on_Tween_tween_completed(object, key):
	if (object == button_container and key == ":modulate"):
		play_button.disabled = false
		volume_button.disabled = false
		exit_button.disabled = false
