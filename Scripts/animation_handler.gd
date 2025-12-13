class_name AnimationHandler
extends Node2D

@onready var _weapon_handler:WeaponHandler = %Weapon
@onready var _animated_sprite:AnimatedSprite2D = $PlayerAnimations

var _is_walking:bool = false
var _is_healing:bool = false
var _is_shooting:bool = false

var _queued_walk:bool = false
var _pending_shot:bool = false
var _current_action:ActionType = ActionType.idle

enum ActionType {
	idle,
	walk,
	shoot,
	heal
}

func _ready() -> void:
	_animated_sprite.animation_finished.connect(_on_animation_finished)

func make_player_idle() -> void:
	if _is_healing or _is_shooting:
		_is_walking = false
		return

	_is_walking = false
	_current_action = ActionType.idle
	_play_animation(ActionType.idle)

func make_player_walk() -> void:
	if _is_healing:
		_queued_walk = true
		return

	if _is_shooting:
		_is_walking = true
		return

	if _is_walking:
		return

	_is_walking = true
	_current_action = ActionType.walk
	_play_animation(ActionType.walk)

func make_player_shoot() -> void:
	if _is_healing:
		return

	if _is_shooting:
		_pending_shot = true
		return

	_is_shooting = true
	_current_action = ActionType.shoot
	_play_animation(ActionType.shoot)

func make_player_heal() -> void:
	if _is_healing:
		return

	_is_healing = true
	_is_shooting = false
	_pending_shot = false

	_queued_walk = false
	_is_walking = false
	_current_action = ActionType.heal
	_play_animation(ActionType.heal)

func _play_animation(action:ActionType) -> void:
	var animation_name:String = _get_animation_weapon() + "_" + _get_animation_action(action)
	var should_loop:bool = _get_loop_stauts(action)

	_animated_sprite.sprite_frames.set_animation_loop(animation_name, should_loop)

	if not should_loop:
		_animated_sprite.stop()
		_animated_sprite.frame = 0

	_animated_sprite.play(animation_name)

func _get_animation_action(action:ActionType) -> String:
	match (action):
		ActionType.idle: return "idle"
		ActionType.walk: return "walk"
		ActionType.shoot: return "shoot"
		ActionType.heal: return "heal"
	return ""

func _get_animation_weapon() -> String:
	match (_weapon_handler.equipted_weapon):
		WeaponHandler.WeaponType.pistol: return "pistol"
		WeaponHandler.WeaponType.smg: return "smg"
		WeaponHandler.WeaponType.assault: return "assault"
		WeaponHandler.WeaponType.sniper: return "sniper"
	return ""

func _get_loop_stauts(action:ActionType) -> bool:
	match (action):
		ActionType.idle: return true
		ActionType.walk: return true
		ActionType.shoot: return false
		ActionType.heal: return false
	return false

func _on_animation_finished() -> void:
	if _current_action == ActionType.heal:
		_is_healing = false
		if _queued_walk:
			_queued_walk = false
			make_player_walk()
		else:
			make_player_idle()
		return

	if _current_action == ActionType.shoot:
		if _pending_shot:
			_pending_shot = false
			_current_action = ActionType.shoot
			_play_animation(ActionType.shoot)
			return

		_is_shooting = false
		if _is_walking:
			make_player_walk()
		else:
			make_player_idle()
		return
