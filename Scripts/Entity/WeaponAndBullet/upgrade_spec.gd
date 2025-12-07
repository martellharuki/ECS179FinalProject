class_name UpgradeSpec
extends Node

@onready var _action_item:ActionItem = %ActionItem

enum UpgradeType {
	mult,
	base
}

const UPGRADE_TYPES = [
	UpgradeType.mult,
	UpgradeType.base
]

enum UpgradeField {
	damage,
	range,
	fire_rate,
	bloom
}

const UPGRADE_FIELDS = [
	UpgradeField.damage,
	UpgradeField.range,
	UpgradeField.fire_rate,
	UpgradeField.bloom
]

var _dmg_mult:float = 1
var _dmg_base:float = 0

var _range_mult:float = 1
var _range_base:float = 0

var _fire_rate_mult:float = 1
var _fire_rate_base: float = 0

var _bloom_mult:float = 1
	
func upgrade_random() -> void:
	var upgrade_type:UpgradeType = UPGRADE_TYPES.pick_random()
	
	match UPGRADE_FIELDS.pick_random():
		UpgradeField.damage:
			if upgrade_type == UpgradeType.mult:
				var amount:float = round_two_places(randf_range(0.05, 0.1))
				_dmg_mult += amount
				_action_item.set_text("Damage + " + str(amount * 100) +"%")
			else:
				var amount:float = round_two_places(randf_range(5, 10))
				_dmg_base += amount
				_action_item.set_text("Damage + " + str(amount))
		UpgradeField.range:
			if upgrade_type == UpgradeType.mult:
				var amount:float = round_two_places(randf_range(0.05, 0.1))
				_range_mult += amount
				_action_item.set_text("Range + " + str(amount * 100) +"%")
			else:
				var amount:float = round_two_places(randf_range(15, 30))
				_range_base += amount
				_action_item.set_text("Range + " + str(amount))
		UpgradeField.fire_rate:
			if upgrade_type == UpgradeType.mult:
				var amount:float = round_two_places(randf_range(0.05, 0.1))
				_fire_rate_mult += amount
				_action_item.set_text("Fire Rate + " + str(amount * 100) +"%")
			else:
				var amount:float = round_two_places(randf_range(1, 3))
				_fire_rate_base += amount
				_action_item.set_text("Fire Rate + " + str(amount))
		UpgradeField.bloom:
			var amount:float = round_two_places(randf_range(0.05, 0.1))
			_bloom_mult -= amount
			_bloom_mult = clampf(_bloom_mult, 0, 1)
			_action_item.set_text("Bloom - " + str(amount * 100) +"%")

func get_upgraded_bullet_spec(damage:float, range:float, lifetime:float) -> BulletSpec:
	var bullet_spec:BulletSpec = BulletSpec.new()
	bullet_spec.damage = (damage + _dmg_base) * _dmg_mult
	
	var total_range:float = (range + _range_base) * _range_mult
	bullet_spec.velocity = (total_range) / lifetime
	
	bullet_spec.range = total_range
	
	return bullet_spec

func get_upgraded_bloom_range(base_bloom:float) -> float:
	return base_bloom * _bloom_mult

func get_upgraded_fire_rate(base_fire_rate:float) -> float:
	return (base_fire_rate + _fire_rate_base) * _fire_rate_mult

func round_two_places(original:float) -> float:
	return round(original * 100) / 100
