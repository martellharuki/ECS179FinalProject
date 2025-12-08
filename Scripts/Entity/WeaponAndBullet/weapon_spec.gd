class_name WeaponSpec

var fire_rate:float
var bullet_range:float
var bullet_damage
var bloom:float

func _init(_fire_rate:float, _bullet_range:float, _bullet_damage:float, _bloom:float) -> void:
	fire_rate = _fire_rate
	bullet_range = _bullet_range
	bullet_damage = _bullet_damage
	bloom = _bloom

static func get_weapon_spec(weapon_type:WeaponHandler.WeaponType) -> WeaponSpec:
	match(weapon_type):
		WeaponHandler.WeaponType.assault:
			return WeaponSpec.new(8, 900, 20, .2)
		WeaponHandler.WeaponType.smg:
			return WeaponSpec.new(14, 600, 12, .35)
		WeaponHandler.WeaponType.sniper:
			return WeaponSpec.new(2, 1200, 60, .1)
	
	return WeaponSpec.new(4, 700, 12, .3)
