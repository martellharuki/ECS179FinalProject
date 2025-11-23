class_name Bullet
extends LiveEntity

@onready var collision_box:Area2D = $BulletArea

var velocity:float = -1
var direction:Vector2

func set_velocity_range_direction(_velocity:float, _range:float, _direction:Vector2, _bloom_offsets:Vector2) -> void:
	velocity = _velocity
	
	var _bullet_duration:float = _range / _velocity
	set_time_lifespan(_bullet_duration)
	
	self.position = Vector2(0, 0)
	var _global_position_saved:Vector2 = self.global_position
	self.set_as_top_level(true)
	self.global_position = _global_position_saved + _direction * 100

	var _bloom_direction = _direction + _bloom_offsets
	_bloom_direction = _bloom_direction.normalized()
	direction = _bloom_direction
	
	rotation = direction.angle() + PI / 2
	print("Position: ", self.global_position)

func handle_bullet_collision(_body:Node) -> void:
	print("Handling hit")
	if _body.is_in_group("player"):
		return
	delete_entity()

func _process(_delta) -> void:
	super(_delta)
	
	self.global_position = self.global_position + direction * velocity * _delta
