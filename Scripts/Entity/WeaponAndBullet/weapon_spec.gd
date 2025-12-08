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
			return WeaponSpec.new(8, 500, 12, .3)
		WeaponHandler.WeaponType.smg:
			return WeaponSpec.new(14, 350, 8, .35)
		WeaponHandler.WeaponType.sniper:
			return WeaponSpec.new(1.5, 900, 60, .2)
	
	return WeaponSpec.new(4, 400, 8, .3)
