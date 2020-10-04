extends Node

var fsm: StateMachine

func enter():
	# Executed when the state is entered. Handles the internal behavior
	# and the exit condition
	if fsm.DEBUG:
		print("Enter level_1_state")
	
	# -----
	# Draw the level 1 screen
	# Wait for action
	# -----
	
	# On close_x change to exit_state
	#exit("Exit")
	# On solution change to level_2_state
	#exit("Level2")
	# On [Main Menu] change to main_menu_state
	#exit("MainMenu")

func exit(next_state):
	# Change to the next state. This operation is handled by the state machine
	fsm.change_to(next_state)

# Optional handler functions for game loop events
# Make sure there is a top level handler in the state machine
# -----
# close_x -> exit_state
# solution -> level_2_state
# [Main Menu] -> main_menu_state
# -----
func input(event):
	pass
