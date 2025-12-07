extends Control

@onready var how_to_play_panel = $HowToPlayPanel
@onready var background = $Background
@onready var title_label = $TitleLabel
@onready var button_container = $VBoxContainer 

func _ready():
	# HowToPlay panel is hidden at start
	if how_to_play_panel:
		how_to_play_panel.visible = false
	
	var start_btn = get_node_or_null("VBoxContainer/StartButton")
	var how_to_btn = get_node_or_null("VBoxContainer/HowToPlayButton")
	var quit_btn = get_node_or_null("VBoxContainer/QuitButton")
	var back_btn = get_node_or_null("HowToPlayPanel/ContentContainer/BackButton")
	
	if start_btn:
		start_btn.pressed.connect(_on_start_pressed)
	
	if how_to_btn:
		how_to_btn.pressed.connect(_on_how_to_play_pressed)
	
	if quit_btn:
		quit_btn.pressed.connect(_on_quit_pressed)
	
	if back_btn:
		back_btn.pressed.connect(_on_back_pressed)

func _on_start_pressed():
	self.visible = false
	
	# Show objective screen right after start is pressed
	ScreenManager.show_objective_screen()
	
	# The objective screen will unpause the game when dismissed

func _on_how_to_play_pressed():
	# Hide main menu elements
	if background:
		background.visible = false
	if title_label:
		title_label.visible = false
	if button_container:
		button_container.visible = false
	
	# Show How To Play panel
	if how_to_play_panel:
		how_to_play_panel.visible = true

func _on_back_pressed():
	# Hide How To Play panel
	if how_to_play_panel:
		how_to_play_panel.visible = false
	
	# Show main menu elements
	if background:
		background.visible = true
	if title_label:
		title_label.visible = true
	if button_container:
		button_container.visible = true

func _on_quit_pressed():
	get_tree().quit()
