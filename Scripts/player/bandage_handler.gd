class_name BandageHandler
extends Node

@export var heal_amount: int = 20
@export var health_bar_path: NodePath

var bandage_count: int = 3

@onready var health_bar: Node = get_node_or_null(health_bar_path)
@onready var _player:= %Player

signal bandage_count_changed(new_count: int)

func _ready() -> void:
	set_process_unhandled_input(true)

func add_bandage(amount: int = 1) -> void:
	bandage_count = max(0, bandage_count + amount)
	_player.set_bandage(bandage_count)
	bandage_count_changed.emit(bandage_count)
	print("Bandage picked up. bandage_count = ", bandage_count)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("bandage"):
		use_bandage()

func use_bandage() -> void:
	if bandage_count < 1:
		print("No bandages available.")
		return
	
	if _player.current_health == _player.max_health:
		print("You cannot heal more")
		return

	if _player == null or not _player.has_method("heal"):
		push_warning("BandageHandler: Player missing or does not have heal(amount).")
		return
		
	bandage_count -= 1
	_player.heal(heal_amount)
	_player.set_bandage(bandage_count)
	bandage_count_changed.emit(bandage_count)
	print("Used bandage. bandage_count = ", bandage_count)
