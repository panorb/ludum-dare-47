extends TextureRect

# All digits
onready var digit := $VBoxContainer/Digit
onready var anim := $DigitAnimation

export(int,1,5) var digit_number := 3
var number := 128 setget set_number # Currently displayed number
var mode := 0 # Which digit are we editing? 10^mode
var correct_answer := 666

signal code_correct
signal new_playback_speed(playback_speed)

func set_number(value):
	emit_signal("new_playback_speed",value)
	number = value

func _ready():
	emit_signal("new_playback_speed",number)
	refresh_number_digits()

# The ui digits need to be refreshed manually after every change
func refresh_number_digits():
	# Make sure that numbers is in constraints
	var max_number := int("9".repeat(digit_number))
	self.number = clamp(number, 0, max_number)
	var number_str := str(number)
	
	# Make sure all number strings are the same digit length
	for i in range(digit_number - len(number_str)):
		number_str = "0" + number_str
		
	#set digit to the Label
	digit.text = number_str

func code_combination_test():
	if number == correct_answer:
		emit_signal("code_correct")

func _on_ButtonAdd_pressed():
	number += pow(10, mode)
	refresh_number_digits()
	code_combination_test()


func _on_ButtonSubtract_pressed():
	number -= pow(10, mode)
	refresh_number_digits()
	code_combination_test()


func _on_ButtonMode_pressed():
	if not anim.is_playing():
		var old_mode = mode
		mode = (mode + 1) % 3
		anim.play("d"+str(3-old_mode)+"tod"+str(3-mode))
	
