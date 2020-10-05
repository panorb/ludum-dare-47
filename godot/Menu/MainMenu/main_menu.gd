extends Control

onready var letter_timer := $LetterTimer
onready var letter_ui := $CanvasLayer/LetterUI

func _on_LetterTimer_timeout():
	letter_ui.show_inbox_notification()
