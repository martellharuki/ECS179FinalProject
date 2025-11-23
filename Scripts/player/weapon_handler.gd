class_name WeaponHandler
extends Node2D

var _fire_rate:float
var _bullet_range:float
var _bullet_velocity:float
var _bloom:float

@onready var _bullet_holder:Node2D = $BulletHolder
@onready var _bullet_scene := preload("res://Scenes/Bullet.tscn")

var _bullet_timer:Timer
var _timer_duration: float = -1

func set_weapon(_weapon_spec:WeaponSpec) -> void:
	_fire_rate = _weapon_spec.fire_rate
	_bullet_range = _weapon_spec.bullet_range
	_bullet_velocity = _weapon_spec.bullet_veloctiy
	_bloom = _weapon_spec.bloom
	
	_timer_duration = 1 / _fire_rate

func handle_weapon_fire(_direction:Vector2) -> void:
	if _fire_rate == 0:
		return
	
	if _bullet_timer == null:
		_make_timer()
		
	if _bullet_timer.is_stopped():
		_make_bullet(_direction)
		_bullet_timer.start(_timer_duration)

func _make_timer() -> void:
	_bullet_timer = Timer.new()
	add_child(_bullet_timer)
	_bullet_timer.one_shot = true

func _make_bullet(_direction:Vector2) -> void:
	var _bullet_entity:Bullet = _bullet_scene.instantiate()
	
	_bullet_holder.add_child(_bullet_entity)
	_bullet_entity.set_velocity_range_direction(_bullet_velocity, _bullet_range, _direction, _get_bloom_direction())
	
func _get_bloom_direction() -> Vector2:
	return Vector2(randf_range(-_bloom, _bloom), randf_range(-_bloom, _bloom))
