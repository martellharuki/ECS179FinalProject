extends Node

signal objective_dismissed

func show_objective_screen():
	var objective = preload("res://Scenes/objective_screen.tscn").instantiate()
	get_tree().current_scene.add_child(objective)

func show_win_screen():
	var win = preload("res://Scenes/win_screen.tscn").instantiate()
	get_tree().current_scene.add_child(win)

func show_lose_screen():
	var lose = preload("res://Scenes/lose_screen.tscn").instantiate()
	get_tree().current_scene.add_child(lose)
