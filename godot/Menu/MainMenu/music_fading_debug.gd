extends Control



func _on_StartMusicButton_pressed():
	SoundController.pub_play_music("res://testmusic/song1.ogg")


func _on_CrossfadeButton_pressed():
	print("Not implemented")
