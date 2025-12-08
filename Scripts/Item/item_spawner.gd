class_name ItemSpawner
extends Node2D
#I change onready to export for testing
@onready var _scrap_scene := preload("res://Scenes/Items/Scrap.tscn")
@onready var _bandage_scene := preload("res://Scenes/Items/Bandage.tscn")
@onready var _smg_scene := preload("res://Scenes/Items/Smg.tscn")
@onready var _assault_scene := preload("res://Scenes/Items/Assault.tscn")
@onready var _sniper_scene := preload("res://Scenes/Items/Sniper.tscn")

@onready var _item_container:Node2D = $ItemContainer
@onready var _spawn_timer:Timer = $SpawnTimer

@export var _total_spawn_points:int
@export var _gun_spawn_chance:float = .05
@export var _zombie_scrap_drop:float = .1
@export var _zombie_bandage_drop:float = .05
@export var _life_duration:float = 20

var _spawn_interval:int = 1
var _open_indecies:Array[int] = []

const SPAWN_POINT_HEADER:String = "ItemSpawnLocationContainer/ItemSpawnPoint"

func _ready() -> void:
	ScreenManager.objective_dismissed.connect(begin_item_spawning)
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
	if roll <= _gun_spawn_chance:
		var random_index:int = randi_range(0, len(_open_indecies) - 1)
		var random_point = _open_indecies[random_index]
		_open_indecies.remove_at(random_index)
		
		var _spawn_node:Node2D = get_node(_get_point_path(random_point))
		#var _spawn_location:Vector2 = _spawn_node.global_position
		var _spawn_location:Vector2 = _get_world_position(_spawn_node.global_position)
		
		var gun_type = WeaponHandler.WEAPON_TYPES.pick_random()
		var gun:DroppedWeapon
		match(gun_type):
			WeaponHandler.WeaponType.smg:
				gun = _smg_scene.instantiate()
			WeaponHandler.WeaponType.assault:
				gun = _assault_scene.instantiate()
			WeaponHandler.WeaponType.sniper:
				gun = _sniper_scene.instantiate()
		
		_item_container.add_child(gun)
		gun.set_time_lifespan(_life_duration)
		gun.set_index_and_location(random_point, _spawn_location, self)

func handle_scrap_spawn(position:Vector2) -> void:
	var total_chance = _zombie_scrap_drop + _zombie_bandage_drop
	var roll = randf()
	if roll < total_chance and roll >= _zombie_scrap_drop:
		var bandage:ItemBase = _bandage_scene.instantiate()
		_item_container.add_child(bandage)
		bandage.set_time_lifespan(_life_duration)
		bandage.set_index_and_location(-1, position, self)
	elif roll < total_chance:
		var scrap:ItemBase = _scrap_scene.instantiate()
		_item_container.add_child(scrap)
		scrap.set_time_lifespan(_life_duration)
		scrap.set_index_and_location(-1, position, self)
		
	
func notify_deleted_item(index:int) -> void:
	print("notified!!")
	if index < 0: return
	_open_indecies.append(index)

func _get_world_position(_position:Vector2) -> Vector2:
	var pixels_per_unit = 13
	return _position / pixels_per_unit
