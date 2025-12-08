#extends Node2D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

class_name ZombieSpawner
extends Node2D

@export var zombie_scene: PackedScene
@export var spawn_radius: float = 900.0        # distance from player
@export var spawn_interval_start: float = 5.0  # seconds
@export var spawn_interval_min: float = 1.5
@export var spawn_interval_decay: float = 0.99  # multiply each wave
@export var zombies_per_wave_start: int = 3
@export var zombies_per_wave_increment: int = 1

@export var base_zombie_health: int = 30
@export var health_increment_per_wave: int = 1

@export var max_zombies_alive: int = 30

var _current_zombie_health: int

var _current_interval: float
var _current_zombies_per_wave: int

@onready var _timer: Timer = $SpawnTimer
@onready var _player: Player = %Player
@onready var _item_spawner:ItemSpawner = %ItemSpawner

func _ready() -> void:
	_current_interval = spawn_interval_start
	_current_zombies_per_wave = zombies_per_wave_start
	_current_zombie_health = base_zombie_health

	_timer.wait_time = _current_interval
	_timer.timeout.connect(_on_spawn_timer_timeout)
	_timer.start()

func _on_spawn_timer_timeout() -> void:
	if _player == null or zombie_scene == null:
		return
		
	var current_zombies := get_tree().get_nodes_in_group("zombies").size()
	if current_zombies >= max_zombies_alive:
		_timer.start()
		return

	for i in range(_current_zombies_per_wave):
		var zombie := zombie_scene.instantiate() as BasicZombie
		get_tree().current_scene.add_child(zombie)
		zombie.global_position = _get_spawn_position_around_player()
		zombie.set_item_spawner(_item_spawner)
		if zombie.has_method("set_stats"):
			zombie.set_stats(_current_zombie_health)

	# ramp difficulty
	_current_zombies_per_wave += zombies_per_wave_increment
	_current_interval = max(spawn_interval_min, _current_interval * spawn_interval_decay)
	_current_zombie_health += health_increment_per_wave
	
	_timer.wait_time = _current_interval
	_timer.start()

func _get_spawn_position_around_player() -> Vector2:
	# pick a random angle around the player
	var angle := randf() * TAU
	var offset := Vector2(cos(angle), sin(angle)) * spawn_radius
	return _player.global_position + offset
