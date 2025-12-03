extends CanvasLayer

@onready var title_screen = $TitleScreen
@onready var pause_screen = $PauseScreen
@onready var player = get_parent().get_node("Player")
@onready var crosshair_layer = get_parent().get_node("CanvasLayer2") 

var is_paused = false
var game_started = false

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
	
	# Connect only Start and Quit buttons (How To Play is handled in TitleScreen script)
	$TitleScreen/VBoxContainer/StartButton.pressed.connect(_on_start_game)
	$TitleScreen/VBoxContainer/QuitButton.pressed.connect(_on_quit)

func _input(event):
	# Only allow pause if game has started
	if game_started and event.is_action_pressed("pause"):
		toggle_pause()

func _on_start_game():
	# Hide title screen and start game
	title_screen.visible = false
	get_tree().paused = false
	game_started = true
	
	# Show crosshair and hide system cursor
	if crosshair_layer:
		crosshair_layer.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

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
	
