extends Control

@onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton
@onready var main_menu_button = $CenterContainer/VBoxContainer/QuitButton  # Still named QuitButton in the scene

func _ready():
	# Connect button signals
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	
	# Make sure this screen works when paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _on_resume_pressed():
	# Get the HUD (parent of this PauseScreen) and call toggle_pause
	get_parent().toggle_pause()

func _on_main_menu_pressed():
	# Return to title screen
	get_parent().return_to_title_screen()
