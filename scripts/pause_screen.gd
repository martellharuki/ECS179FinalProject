extends Control

@onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton


func _ready():
	# Connect button signals
	resume_button.pressed.connect(_on_resume_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Make sure this screen works when paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	

func _on_resume_pressed():
	# Tell Main to unpause
	get_parent().get_parent().toggle_pause()


func _on_quit_pressed():
	# Unpause before quitting
	get_tree().paused = false
	# Quit the game
	get_tree().quit()
