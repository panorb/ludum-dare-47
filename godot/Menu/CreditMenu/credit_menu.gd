extends ColorRect


func _ready():
	get_child(1).play("CreditsScroll", 1, 3)




func _on_AnimationPlayer_animation_finished(anim_name):
		get_tree().change_scene("res://Menu/MainMenu/MainMenu.tscn")
