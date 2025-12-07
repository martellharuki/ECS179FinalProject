extends CanvasLayer

var can_dismiss = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS  # Process even when paused
	layer = 10  # Make sure it's on top
	get_tree().paused = true  # YES - Game is paused while objective is shown
	
	# Hide system cursor and show crosshair during objective screen
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	# Small delay before allowing dismissal
	await get_tree().create_timer(0.3, true, false, true).timeout
	can_dismiss = true

func _input(event):
	if not can_dismiss:
		return
		
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		_dismiss()
	elif event is InputEventMouseButton and event.is_pressed():
		_dismiss()

func _dismiss():
	can_dismiss = false  # Prevent multiple dismissals
	get_tree().paused = false  # Unpause the game
	ScreenManager.objective_dismissed.emit()
	queue_free()
