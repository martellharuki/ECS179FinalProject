class_name Bullet
extends LiveEntity

@onready var collision_box:Area2D = $BulletArea

var velocity:float = -1
var direction:Vector2

func set_velocity_range_direction(_velocity:float, _range:float, _direction:Vector2) -> void:
	velocity = _velocity
	direction = _direction
	
	var _bullet_duration:float = _range / _velocity
	set_time_lifespan(_bullet_duration)

func handle_bullet_collision(_body) -> void:
	print("Handling hit")
	delete_entity()

func _process(_delta) -> void:
	super(_delta)
	
