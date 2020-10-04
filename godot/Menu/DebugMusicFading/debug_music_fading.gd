extends Control

onready var tween = $Tween
onready var combination_lock = $HBoxContainer/VBoxContainer/CombinationLock

const DISTANCE_FADE_START = 220
var k : float = 0 setget set_music_mix

func _ready():
	SoundController.pub_play_music("res://testmusic/song1.ogg", 0, linear2db(1))
	SoundController.pub_play_music("res://testmusic/song2.ogg", 1, linear2db(0))
	refresh_music_mix()
	
func _on_StartMusicButton_pressed():
	_ready()
	refresh_music_mix()

func refresh_music_mix():
	var distance := abs(combination_lock.correct_answer - combination_lock.number)
	
	tween.stop_all()
	
	var new_k = 1 if distance > DISTANCE_FADE_START else float(distance) / DISTANCE_FADE_START
	var change_speed = lerp(0, 0.2, abs(new_k-k))
	tween.interpolate_property(self, "k", null, new_k, lerp(0, 0.2, abs(1-k)))
	
	tween.start()

func set_music_mix(new_k : float):
	k = new_k
	var volume_1 = linear2db(k)
	var volume_2 = linear2db(1-k)
	
	SoundController.pub_set_music_volume_db(0, volume_1)
	SoundController.pub_set_music_volume_db(1, volume_2)

func _on_CombinationLock_new_playback_speed(playback_speed):
	if combination_lock: # This is really hacky. Why is the signal called before the combiock is ready?
		refresh_music_mix()
	
	
