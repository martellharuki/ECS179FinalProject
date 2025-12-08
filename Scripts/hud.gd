class_name HUDHandler
extends CanvasLayer

@onready var title_screen = $TitleScreen
@onready var pause_screen = $PauseScreen
#@onready var _item_spawner:ItemSpawner = %ItemSpawner
@onready var player = get_parent().get_node("Player")
@onready var crosshair_layer = get_parent().get_node("CanvasLayer2")
@onready var _bandage_text:Label = $"Hotbar/WeaponSlot1/Label"
@onready var _scrap_text:Label = $"Hotbar/WeaponSlot2/Label"
@onready var score_label = $ScoreLabel

var is_paused = false
var game_started = false
var current_score: int = 0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Start with title screen visible
	title_screen.visible = true
	pause_screen.visible = false
	get_tree().paused = true
	
	# Hide crosshair and show system cursor at start
	if crosshair_layer:
		crosshair_layer.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Connect buttons
	$TitleScreen/VBoxContainer/StartButton.pressed.connect(_on_start_game)
	$TitleScreen/VBoxContainer/QuitButton.pressed.connect(_on_quit)
	
	update_score_display()
	# Connect to objective dismissed signal
	#ScreenManager.objective_dismissed.connect(_on_objective_dismissed)
	
func _input(event):
	# Only allow pause if game has started
	if game_started and event.is_action_pressed("pause"):
		toggle_pause()

func _on_start_game():
	# Hide title screen
	title_screen.visible = false
	
	reset_score()
	
	# DON'T unpause or start spawning yet - objective screen will handle that
	game_started = true
	
	# Show crosshair (will be visible after objective is dismissed)
	if crosshair_layer:
		crosshair_layer.visible = true

#func _on_objective_dismissed():
	# This is called when player dismisses the objective screen
	# Now actually start the game
#	_item_spawner.begin_item_spawning()

func _on_quit():
	get_tree().quit()

func toggle_pause():
	is_paused = !is_paused
	
	if is_paused:
		pause_screen.visible = true
		get_tree().paused = true
		# Show system cursor when paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		if crosshair_layer:
			crosshair_layer.visible = false
	else:
		pause_screen.visible = false
		get_tree().paused = false
		# Hide system cursor and show crosshair when unpaused
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		if crosshair_layer:
			crosshair_layer.visible = true

func return_to_title_screen():
	# Hide pause screen
	pause_screen.visible = false
	is_paused = false
	
	# Show title screen
	title_screen.visible = true
	game_started = false
	
	# Reset game state
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if crosshair_layer:
		crosshair_layer.visible = false
		
func set_bandage_count(amount:int) -> void:
	_bandage_text.text = str(amount)
	
func set_scrap_count(amount:int) -> void:
	_scrap_text.text = str(amount)
	
func add_score(points: int):
	current_score += points
	update_score_display()

func update_score_display():
	if score_label:
		score_label.text = "Score: " + str(current_score)

func get_current_score() -> int:
	return current_score

func reset_score():
	current_score = 0
	update_score_display()
