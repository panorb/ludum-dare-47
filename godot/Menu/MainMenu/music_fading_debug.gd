extends Control

onready var tween = $Tween

func _on_StartMusicButton_pressed():
	SoundController.pub_play_effect("res://testmusic/song1.ogg", 0)
	SoundController.pub_play_effect("res://testmusic/song2.ogg", 1, -100)


func _on_CrossfadeButton_pressed():
	var sound_layer_0 := SoundController.pub_get_audio_effect_player(0)
	var sound_layer_1 := SoundController.pub_get_audio_effect_player(1)
	
	# sound_layer_0.volume_db = -100
	#sound_layer_1.volume_db = -100
	
	tween.interpolate_property(sound_layer_0, "volume_db", null, -100, 1, Tween.TRANS_CIRC)
	tween.interpolate_property(sound_layer_1, "volume_db", null, -12, 2, Tween.TRANS_CIRC)
	tween.start()
