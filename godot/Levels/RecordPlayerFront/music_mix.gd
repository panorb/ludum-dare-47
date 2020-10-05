extends Node

onready var tween = $Tween
onready var combination_lock = $"../Interactables/CombinationLock"

export(String, FILE, "*.ogg") var bgm_unsolved := ""
export(String, FILE, "*.ogg") var bgm_solved := ""

export(int) var distance_fade_start : float = 40
export(int) var distance_pitch_start : float = 800
export(float) var max_transition_time : float = 3

var k : float = 0 setget set_music_mix

func _ready():
	SoundController.pub_play_music(bgm_unsolved, 0, linear2db(1))
	SoundController.pub_play_music(bgm_solved, 1, linear2db(0))
	refresh_music_mix()

func refresh_music_mix():
	yield(get_tree(), "idle_frame")
	var difference : int = combination_lock.correct_answer - combination_lock.number
	SoundController.pub_set_music_pitch_scale(1, 1 - (float(difference) / distance_pitch_start))
	
	var distance : int = abs(difference)
	
	tween.stop_all()
	
	var new_k = 1 if distance > distance_fade_start else float(distance) / distance_fade_start
	var change_speed = lerp(0, max_transition_time, abs(new_k-k))
	tween.interpolate_property(self, "k", null, new_k, change_speed)
	
	tween.start()
	

func set_music_mix(new_k : float):
	k = new_k
	var volume_1 = linear2db(k)
	var volume_2 = linear2db(1-k)
	
	SoundController.pub_set_music_volume_db(0, volume_1)
	SoundController.pub_set_music_volume_db(1, volume_2)

func _on_CombinationLock_new_playback_speed(playback_speed):
	refresh_music_mix()
