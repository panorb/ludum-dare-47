extends Control

onready var vinyl = $RecordPlayer/Vinyl
onready var combinationLock = $RecordPlayer/CombinationLock
onready var recordPlayerNeedle = $RecordPlayer/RecordPlayerNeedle
onready var mouseHotspot = $RecordPlayer/MouseHotspot

# Called when the node enters the scene tree for the first time.
func _ready():
	mouseHotspot.hide()
	combinationLock.connect("new_playback_speed",vinyl,"update_playback_speed")
	combinationLock.connect("new_playback_speed",recordPlayerNeedle,"update_playback_speed")

func _on_CombinationLock_code_correct():
	SoundController.pub_play_effect("res://Levels/RecordPlayerFront/Sounds/finalKlick.ogg",5)
	mouseHotspot.show()
	
func _on_MouseHotspot_is_pressed():
	get_tree().change_scene("res://Menu/MainMenu/MainMenu.tscn")
