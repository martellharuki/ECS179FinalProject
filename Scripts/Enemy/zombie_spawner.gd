class_name ZombieSpawner
extends Node2D

@export var zombie_scene: PackedScene
@export var scissor_zombie_scene: PackedScene
@export var lump_zombie_scene: PackedScene

@export var spawn_bounds: Rect2 = Rect2(Vector2(-6747.0, -6614.0), Vector2(31315, 15951))

@export_flags_2d_physics var environment_mask: int

@export var spawn_radius: float = 900.0        # distance from player
# Wave management
@export var spawn_interval_start: float = 5.0  # seconds
@export var spawn_interval_min: float = 1.5
@export var spawn_interval_decay: float = 0.99  # multiply each wave
# Wave Scale
@export var zombies_per_wave_start: int = 2
@export var zombies_per_wave_increment: int = 1
# Basic zombie health Scale
@export var base_zombie_health: int = 20
@export var health_increment_per_wave: int = 5
# Max zombie Cap
@export var max_zombies_alive: int = 15
@export var max_zombies_alive_increment: int = 1

@export var boss_wave: int = 10 
@export var boss_spawn_time: float = -1.0 # seconds this method currently disabled

@export var lump_spawn_chance: float = 0.33
@export var lump_start_wave: int = 2

var _current_zombie_health: int

var _current_interval: float
var _current_zombies_per_wave: int
var _current_max_zombies_alive: int

var _wave_index: int = 0
var _boss_spawned: bool = false
var _elapsed_time: float = 0.0

@onready var _timer: Timer = $SpawnTimer
@onready var _player: Player = %Player
@onready var _item_spawner:ItemSpawner = %ItemSpawner

func _ready() -> void:
	randomize()
	
	_current_interval = spawn_interval_start
	_current_zombies_per_wave = zombies_per_wave_start
	_current_zombie_health = base_zombie_health
	_current_max_zombies_alive = max_zombies_alive

	_timer.wait_time = _current_interval
	_timer.timeout.connect(_on_spawn_timer_timeout)
	_timer.start()

func _process(delta: float) -> void:
	# optional time-based boss spawn (e.g. after 30s)
	if boss_spawn_time > 0.0 and not _boss_spawned:
		_elapsed_time += delta
		if _elapsed_time >= boss_spawn_time:
			_spawn_boss()

func _on_spawn_timer_timeout() -> void:
	if _player == null or zombie_scene == null:
		return
		
	var current_zombies := get_tree().get_nodes_in_group("zombies").size()
	if current_zombies >= _current_max_zombies_alive:
		_timer.start()
		return

	for i in range(_current_zombies_per_wave):
		#var zombie := zombie_scene.instantiate() as BasicZombie
		#get_tree().current_scene.add_child(zombie)
		#zombie.global_position = _get_spawn_position_around_player()
		var spawn_pos = _get_spawn_position_around_player()
		var zombie: BasicZombie
		var use_lump := false
		if _wave_index >= lump_start_wave and lump_zombie_scene:
			use_lump = randf() < lump_spawn_chance
		
		if use_lump:
			zombie = lump_zombie_scene.instantiate() as BasicZombie
		else:
			zombie = zombie_scene.instantiate() as BasicZombie
		
		if zombie == null:
			continue
		
		get_tree().current_scene.add_child(zombie)
		zombie.global_position = spawn_pos
		if zombie.has_method("set_item_spawner"):
		# I will not change this since it's about item spawning
		# does it also need if statement? like: if zombie.has_method("set_item_spawner"):
			zombie.set_item_spawner(_item_spawner)
		if zombie.has_method("set_stats"):
			zombie.set_stats(_current_zombie_health)
	
	_wave_index += 1
	
	if boss_wave > 0 and _wave_index == boss_wave and not _boss_spawned:
		_spawn_boss()

	# ramp difficulty
	_current_zombies_per_wave += zombies_per_wave_increment
	_current_interval = max(spawn_interval_min, _current_interval * spawn_interval_decay)
	_current_zombie_health += health_increment_per_wave
	_current_max_zombies_alive += max_zombies_alive_increment
	
	_timer.wait_time = _current_interval
	_timer.start()

func _spawn_boss() -> void:
	if scissor_zombie_scene == null:
		return
	
	var boss := scissor_zombie_scene.instantiate() as ScissorZombie
	get_tree().current_scene.add_child(boss)
	boss.global_position = _get_spawn_position_around_player()
	
	if boss.has_method("set_item_spawner"):
		boss.set_item_spawner(_item_spawner) #currently useless for us cause set to win
	
	_boss_spawned = true

func _get_spawn_position_around_player() -> Vector2:
	var space_state := get_world_2d().direct_space_state
	
	for i in range(16):
		# pick a random angle around the player
		var angle := randf() * TAU
		var offset := Vector2(cos(angle), sin(angle)) * spawn_radius
		#return _player.global_position + offset
		var pos := _player.global_position + offset
		
		pos.x = clampf(pos.x, spawn_bounds.position.x, spawn_bounds.position.x + spawn_bounds.size.x)
		pos.y = clampf(pos.y, spawn_bounds.position.y, spawn_bounds.position.y + spawn_bounds.size.y)
		
		var params := PhysicsPointQueryParameters2D.new()
		params.position = pos
		params.collision_mask = environment_mask
		params.collide_with_areas = true
		params.collide_with_bodies = true
		
		var result: Array = space_state.intersect_point(params, 8)
		
		if result.is_empty():
			return pos
		
	return _player.global_position
