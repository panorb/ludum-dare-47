extends Node

var fsm: StateMachine

func enter():
	# Executed when the state is entered. Handles the internal behavior
	# and the exit condition
	if fsm.DEBUG:
		print("Enter exit_state")
	
	# -----
	# This state does nothing (currently)
	# Maybe ask for confirmation
	# -----
	
	exit("Intro")

func exit(next_state):
	fsm.change_to(next_state)

# Optional handler functions for game loop events
# Make sure there is a top level handler in the state machine
# -----
# No handlers are needed in this state as it does nothing (currently)
# Maybe handle input for confirmation
# -----

#func input(event):
#	pass
