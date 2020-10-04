extends Node

class_name StateMachine

const DEBUG = true

var state: Object

var history = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# set the initial state to the first child node
	state = get_child(0)
	_enter_state()

func change_to(new_state):
	# append the current state to the history; change to the next state
	history.append(state.name)
	state = get_node(new_state)
	_enter_state()


func back():
	# go back one state and remove the state from the history
	if history.size > 0:
		state = get_node(history.pop_back())
		_enter_state()

func _enter_state():
	# give the new state a reference to this state machine script
	if DEBUG:
		print("Entering state: ", state.name)
	state.fsm = self
	state.enter()

# Redirect function calls to current state handler if the function exists there
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state.has_method("process"):
		state.process(delta)

# Called every time an input happens. 'event' is an handler to the input event
func _input(event):
	if state.has_method("input"):
		state.input(event)
