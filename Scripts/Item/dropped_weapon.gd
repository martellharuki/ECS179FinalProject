class_name DroppedWeapon
extends ItemBase

@export var _weapon_type:WeaponHandler.WeaponType

func get_gun_type() -> WeaponHandler.WeaponType:
	return _weapon_type
	
