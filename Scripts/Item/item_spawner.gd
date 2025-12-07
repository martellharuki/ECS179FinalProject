class_name ItemSpawner
extends Node2D

@onready var _scrap_scene := preload("res://Scenes/Items/Scrap.tscn")
@onready var _item_container:Node2D = $ItemContainer
@onready var _spawn_timer:Timer = $SpawnTimer

@export var _total_spawn_points:int
@export var _spawn_interval:int = 1
@export var _spawn_chance:float = .2
@export var _gun_chance:float = .1

@export var _life_duration:float = 20

var _open_indecies:Array[int] = []

const SPAWN_POINT_HEADER:String = "ItemSpawnLocationContainer/ItemSpawnPoint"

func _ready() -> void:
	_spawn_timer.connect("timeout", _handle_item_spawning)
	
	for i in range(_total_spawn_points):
		_open_indecies.append(i)

func begin_item_spawning() -> void:
	_spawn_timer.start(_spawn_interval)
	
func _get_point_path(index:int) -> String:
	return SPAWN_POINT_HEADER + str(index)

func _handle_item_spawning() -> void:
	if len(_open_indecies) == 0:
		return
	
	var roll = randf()
	if roll <= _spawn_chance:
		var random_index:int = randi_range(0, len(_open_indecies) - 1)
		var random_point = _open_indecies[random_index]
		_open_indecies.remove_at(random_index)
		
		var _spawn_node:Node2D = get_node(_get_point_path(random_point))
		#var _spawn_location:Vector2 = _spawn_node.global_position
		var _spawn_location:Vector2 = _get_world_position(_spawn_node.global_position)
		
		var scrap:ItemBase = _scrap_scene.instantiate()
		_item_container.add_child(scrap)
		scrap.set_time_lifespan(_life_duration)
		scrap.set_index_and_location(random_point, _spawn_location, self)
		print("added at: " + str(_spawn_location))
		print("player at: " + str(%Player.global_position))
		
func notify_deleted_item(index:int) -> void:
	print("notified!!")
	_open_indecies.append(index)

func _get_world_position(_position:Vector2) -> Vector2:
	var pixels_per_unit = 13
	return _position / pixels_per_unit
