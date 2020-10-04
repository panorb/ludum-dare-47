extends Control

onready var vinyl = $RecordPlayer/Vinyl
onready var combinationLock = $RecordPlayer/CombinationLock
onready var recordPlayerNeedle = $RecordPlayer/RecordPlayerNeedle

# Called when the node enters the scene tree for the first time.
func _ready():
	combinationLock.connect("new_playback_speed",vinyl,"update_playback_speed")
	combinationLock.connect("new_playback_speed",recordPlayerNeedle,"update_playback_speed")


func _on_CombinationLock_code_correct():
	print("You did it!")
