extends Control

onready var vinyl = $RecordPlayer/Vinyl
onready var combination_lock = $Interactables/Control/CombinationLock
onready var record_player_needle = $RecordPlayer/RecordPlayerNeedle
onready var record_player = $RecordPlayer
onready var mouse_hotspot = $Interactables/Control/MouseHotspot
onready var player_hint = $Interactables/Control/PlayerHint
onready var _tween = $Tween
onready var control_puzzle0 = $Interactables/Control
onready var puzzle_area = $Interactables/Puzzels.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_hotspot.hide()	
	player_hint.hide()
	combination_lock.connect("new_playback_speed",vinyl,"update_playback_speed")
	combination_lock.connect("new_playback_speed",record_player_needle,"update_playback_speed")

func _on_CombinationLock_code_correct():
	SoundController.pub_play_effect("res://Levels/RecordPlayerFront/CombinationLock/combi_lock_correct.wav", 5, linear2db(8 * A.vol_mul))
	puzzle_area[0].show()
	_tween.interpolate_property(control_puzzle0, "margin_left", null, -10, 0.5, Tween.TRANS_EXPO)
	_tween.start()
	mouse_hotspot.show()
	player_hint.show()
	player_hint.get_node("HintFadeIn").play("FadeIn")
	
	
func _on_MouseHotspot_is_pressed():
	SoundController.pub_play_effect("res://Levels/RecordPlayerFront/panel_woosh.wav", 4, linear2db(10 * A.vol_mul))
	_tween.interpolate_property(control_puzzle0, "margin_left", null, -1800, 1.5, Tween.TRANS_EXPO)
	_tween.interpolate_property(control_puzzle0, "margin_right", null, -1500, 1.5, Tween.TRANS_EXPO)
	_tween.start()
	player_hint.hide()



func _on_PuzzleOneController_done():
	puzzle_area[1].show()
	puzzle_area[0].hide()


func _on_PuzzleTwoController_done():
	puzzle_area[2].show()
	puzzle_area[1].hide()


func _on_PuzzleThreeController_done():
	record_player.hide()
	puzzle_area[3].show()
	puzzle_area[2].hide()
	


func _on_PuzzleFourController_done():
	SceneChanger("res://Levels/Outro/OutroScene.tscn")
