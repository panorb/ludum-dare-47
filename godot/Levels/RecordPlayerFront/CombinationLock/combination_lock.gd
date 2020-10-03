extends VBoxContainer

# All digits
onready var digits := $ContainerDigits.get_children()

var number := 123 # Currently displayed number
var mode := 0 # Which digit are we editing? 10^mode

func _ready():
	refresh_number_digits()

# The ui digits need to be refreshed manually after every change
func refresh_number_digits():
	# Make sure that numbers is in constraints
	var max_number := int("9".repeat(len(digits)))
	number = clamp(number, 0, max_number)
	var number_str := str(number)
	
	# Make sure all number strings are the same digit length
	for i in range(len(digits) - len(number_str)):
		number_str = "0" + number_str
	
	# Set the individual ui digits to their value
	for i in len(number_str):
		digits[i].text = number_str[i]

func _on_ButtonAdd_pressed():
	number += pow(10, mode)
	refresh_number_digits()


func _on_ButtonSubtract_pressed():
	number -= pow(10, mode)
	refresh_number_digits()


func _on_ButtonMode_pressed():
	mode = (mode + 1) % 3
