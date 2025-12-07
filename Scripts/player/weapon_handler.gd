class_name WeaponHandler
extends Node2D

const BULLET_LIFETIME:float = 0.3
var _fire_rate:float
var _bullet_range:float
var _bullet_damage:float
var _bloom:float

@onready var _bullet_holder:Node2D = $BulletHolder
@onready var _bullet_scene := preload("res://Scenes/Bullet.tscn")

var _bullet_timer:Timer

func set_weapon(_weapon_spec:WeaponSpec) -> void:
	_fire_rate = _weapon_spec.fire_rate
	_bullet_range = _weapon_spec.bullet_range
	_bullet_damage = _weapon_spec.bullet_damage
	_bloom = _weapon_spec.bloom

func handle_weapon_fire(_direction:Vector2) -> void:
	if _fire_rate == 0:
		return
	
	if _bullet_timer == null:
		_make_timer()
		
	if _bullet_timer.is_stopped():
		_make_bullet(_direction)
		var timer_duration:float = 1 / UpgradeSpec.upgrade_spec.get_upgraded_fire_rate(_fire_rate)
		_bullet_timer.start(timer_duration)

func _make_timer() -> void:
	_bullet_timer = Timer.new()
	add_child(_bullet_timer)
	_bullet_timer.one_shot = true

func _make_bullet(_direction:Vector2) -> void:
	var _bullet_entity:Bullet = _bullet_scene.instantiate()
	
	_bullet_holder.add_child(_bullet_entity)
	var bullet_spec:BulletSpec = UpgradeSpec.upgrade_spec.get_upgraded_bullet_spec(_bullet_damage, _bullet_range, BULLET_LIFETIME)
	_bullet_entity.set_velocity_range_direction(bullet_spec, _direction, _get_bloom_direction())
	
func _get_bloom_direction() -> Vector2:
	var bloom_range:float = UpgradeSpec.upgrade_spec.get_upgraded_bloom_range(_bloom)
	return Vector2(randf_range(-bloom_range, bloom_range), randf_range(-bloom_range, bloom_range))
	
