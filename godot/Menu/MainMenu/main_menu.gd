extends MarginContainer



func _on_StartButton_pressed():
	print("Not implemented")


func _on_LoadGameButton_pressed():
	print("Not implemented")


func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Menu/CreditMenu/CreditMenu.tscn")


func _on_SettingsButton_pressed():
	print("Not implemented")


func _on_ExitButton_pressed():
	get_tree().quit()
