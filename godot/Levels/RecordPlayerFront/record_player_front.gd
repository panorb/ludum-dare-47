extends Control

onready var vinyl = $RecordPlayer/Vinyl
onready var combination_lock = $Interactables/Control/CombinationLock
onready var record_player_needle = $RecordPlayer/RecordPlayerNeedle
onready var mouse_hotspot = $Interactables/Control/MouseHotspot
onready var player_hint = $Interactables/Control/PlayerHint
onready var _tween = $Tween
onready var control_puzzle0 = $Interactables/Control

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_hotspot.hide()	
	player_hint.hide()
	combination_lock.connect("new_playback_speed",vinyl,"update_playback_speed")
	combination_lock.connect("new_playback_speed",record_player_needle,"update_playback_speed")

func _on_CombinationLock_code_correct():
	SoundController.pub_play_effect("res://Levels/RecordPlayerFront/CombinationLock/slate_clack.ogg",5)
	_tween.interpolate_property(control_puzzle0, "margin_left", null, -10, 0.5, Tween.TRANS_EXPO)
	_tween.start()
	mouse_hotspot.show()
	player_hint.show()
	player_hint.get_node("HintFadeIn").play("FadeIn")
	
func _on_MouseHotspot_is_pressed():
	SoundController.pub_play_effect("res://Levels/RecordPlayerFront/panel_woosh.wav", 3, 10)
	_tween.interpolate_property(control_puzzle0, "margin_left", null, -1800, 1.5, Tween.TRANS_EXPO)
	_tween.interpolate_property(control_puzzle0, "margin_right", null, -1500, 1.5, Tween.TRANS_EXPO)
	_tween.start()
	player_hint.hide()

