extends PanelContainer

onready var letter_label := $HBoxContainer/VBoxContainer/Label
export(String) var letter_text := ""

# Called when the node enters the scene tree for the first time.
func _ready():
	letter_label.text = letter_text
