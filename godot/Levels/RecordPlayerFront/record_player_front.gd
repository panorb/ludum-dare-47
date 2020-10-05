extends Control

onready var vinyl = $RecordPlayer/Vinyl
onready var combinationLock = $RecordPlayer/CombinationLock
onready var recordPlayerNeedle = $RecordPlayer/RecordPlayerNeedle
onready var mouseHotspot = $RecordPlayer/MouseHotspot
onready var _tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	mouseHotspot.hide()	
	combination_lock.connect("new_playback_speed",vinyl,"update_playback_speed")
	combination_lock.connect("new_playback_speed",record_player_needle,"update_playback_speed")

func _on_CombinationLock_code_correct():
	SoundController.pub_play_effect("res://Levels/RecordPlayerFront/Sounds/finalKlick.ogg",5)
	mouseHotspot.show()
	SoundController.pub_play_effect("res://Levels/RecordPlayerFront/panel_woosh.wav", 3, 10)
	_tween.interpolate_property(combination_lock, "margin_left", null, -1200, 1.5, Tween.TRANS_EXPO)
	_tween.start()
