class_name WeaponSpec

var fire_rate:float
var bullet_range:float
var bullet_damage
var bloom:float

func _init(_bullet_damage:float, _fire_rate:float, _bullet_range:float, _bloom:float) -> void:
	fire_rate = _fire_rate
	bullet_range = _bullet_range
	bloom = _bloom
	bullet_damage = _bullet_damage
