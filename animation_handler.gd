class_name AnimationHandler
extends Node2D

@onready var _weapon_handler:WeaponHandler = %Weapon
@onready var _animated_sprite:AnimatedSprite2D = $PlayerAnimations

var _is_walking:bool = false
#var _is_shooting:bool = false
#var _is_healing:bool = false

enum ActionType {
	idle,
	walk,
	shoot,
	heal
}

func make_player_idle() -> void:
	_is_walking = false
	
	_play_animation(ActionType.idle)

func make_player_walk() -> void:
	if _is_walking:
		return
	
	_is_walking = true
	_play_animation(ActionType.walk)

func make_player_shoot() -> void:
	_play_animation(ActionType.shoot)

func make_player_heal() -> void:
	_play_animation(ActionType.heal)

func _play_animation(action:ActionType) -> void:
	var should_loop:bool = _get_loop_stauts(action)
	var animation_name:String = _get_animation_weapon() + "_" + _get_animation_action(action)
	_animated_sprite.play(animation_name, 1, should_loop)

func _get_animation_action(action:ActionType) -> String:
	match (action):
		ActionType.idle:
			return "idle"
		ActionType.walk:
			return "walk"
		ActionType.shoot:
			return "shoot"
		ActionType.heal:
			return "heal"
	
	return ""

func _get_animation_weapon() -> String:
	match (_weapon_handler.equipted_weapon):
		WeaponHandler.WeaponType.pistol:
			return "pistol"
		WeaponHandler.WeaponType.smg:
			return "smg"
		WeaponHandler.WeaponType.assault:
			return "assault"
		WeaponHandler.WeaponType.sniper:
			return "sniper"
	
	return ""

func _get_loop_stauts(action:ActionType) -> bool:
	match (action):
		ActionType.idle:
			return true
		ActionType.walk:
			return true
		ActionType.shoot:
			return false
		ActionType.heal:
			return false
	
	return false
