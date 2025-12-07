extends Control
@onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton
@onready var main_menu_button = $CenterContainer/VBoxContainer/QuitButton  

func _ready():
	# Connect button signals
	resume_button.pressed.connect(_on_resume_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	
	# Make sure this screen works when paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _on_resume_pressed():
	get_parent().toggle_pause()

func _on_main_menu_pressed():
	# Unpause the game first
	get_tree().paused = false
	
	# Reload the entire scene (this resets everything)
	get_tree().reload_current_scene()
