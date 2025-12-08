extends CanvasLayer

@onready var final_score_label = $CenterContainer/VBoxContainer/FinalScoreLabel

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 10
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	var hud = get_tree().get_first_node_in_group("hud")
	if hud and final_score_label:
		final_score_label.text = "Final Score: " + str(hud.get_current_score())

func _input(event):
	# Block ALL input except mouse clicks on UI
	if event is InputEventKey:
		get_viewport().set_input_as_handled()

func _on_continue_pressed():
	# Unpause and reload to title screen
	get_tree().paused = false
	
	# Get current scene path and reload it
	var current_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene_path)
