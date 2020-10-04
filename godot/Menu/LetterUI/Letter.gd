extends CenterContainer

onready var letter_label := $PanelContainer/HBoxContainer/VBoxContainer/Label
export(String) var dialouge_name := ""

# Called when the node enters the scene tree for the first time.
func _ready():
	letter_label.text = dialouge_name
