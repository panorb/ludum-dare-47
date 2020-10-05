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
var over := false

func _ready():
	SoundController.connect("song_finished", self, "_on_song_finished")

func _on_LetterTimer_timeout():
	letter_ui.show_inbox_notification()

func _on_LetterUI_letter_unfocused():
	video_player.play()
	yield(get_tree().create_timer(0.1), "timeout")
	video_player.visible = true
	SoundController.pub_play_music("res://Shared/intro_with_melody.ogg", 1, linear2db(6*A.vol_mul))

func _on_VideoPlayer_finished():
	print("_on_VideoPlayer_finished")
	if over:
		SceneChanger.change_scene("res://Levels/RecordPlayerFront/RecordPlayerFront.tscn")
	else:
		_tween.interpolate_property(button_container, ":modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 2, Tween.TRANS_SINE)
		_tween.start()

func _on_Tween_tween_completed(object, key):
	if (object == button_container and key == ":modulate"):
		play_button.disabled = false
		volume_button.disabled = false
		exit_button.disabled = false

# Switch to song without melody after first loop.
# First part of song was imported with loop off
func _on_song_finished(channel: int):
	if channel == 1:
		SoundController.pub_play_music("res://Shared/intro_without_melody.ogg", 1, linear2db(6*A.vol_mul))


func _on_button_mouse_entered():
	SoundController.pub_play_effect("res://Menu/option_switched.wav", 2, linear2db(10 * A.vol_mul))


func _on_PlayButton_pressed():
	over = true
	video_player.stream = load("res://Menu/MainMenu/button_press.ogv")
	video_player.play()
	_tween.interpolate_property(button_container, ":modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2, Tween.TRANS_SINE)
	_tween.start()


func _on_ExitButton_pressed():
	get_tree().quit()
