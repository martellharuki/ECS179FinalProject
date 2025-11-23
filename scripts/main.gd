extends Node2D

@onready var hud = $HUD
@onready var pause_screen = $HUD/PauseScreen 
@onready var player = $Player

var is_paused = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_screen.hide()
	
func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	
	if is_paused:
		pause_screen.show() 
		get_tree().paused = true
		print("Game paused")
	else:
		pause_screen.hide()  
		get_tree().paused = false
		print("Game unpaused")
