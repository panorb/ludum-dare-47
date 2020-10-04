extends Node

var fsm: StateMachine

func enter():
	# Executed when the state is entered. Handles the internal behavior
	# and the exit condition
	if fsm.DEBUG:
		print("Enter main_menu_state")
	
	# -----
	# Draw the main menu screen
	# Wait for action
	# -----
	
	# Leaving this state requires an input from the user
	#exit("Exit")

func exit(next_state):
	# Change to the next state. This operation is handled by the state machine
	fsm.change_to(next_state)

# Optional handler functions for game loop events
# Make sure there is a top level handler in the state machine
# -----
# [Exit] | close_x -> exit_state
# [Start] -> level1_state
# -----
func input(event):
	pass
