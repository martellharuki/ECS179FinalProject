class_name Audio_Handler
extends Node2D


@onready var _gun_shot_player:AudioStreamPlayer2D = $Gunshot
@onready var _zombie_hurt_player: AudioStreamPlayer2D = $PlayerHurt
@onready var _player_heal_player: AudioStreamPlayer2D = $PlayerHeal

func _jitter_pitch(player: AudioStreamPlayer2D, base: float = 1.0, amount: float = 0.05) -> void:
	if player == null:
		return
	var p := base + randf_range(-amount, amount)   # e.g. 0.95 ~ 1.05
	player.pitch_scale = p

var _is_shooting:bool = false

func play_gunshot_sound() -> void:
	if not _is_shooting:
		_gun_shot_player.play()
		_is_shooting = true
	
func stop_gunshot_sound() -> void:
	if _is_shooting:
		_gun_shot_player.stop()
		_is_shooting = false
	
func play_player_hurt_sound() -> void:
	if _zombie_hurt_player:
		_jitter_pitch(_zombie_hurt_player, 1.0, 0.08)
		_zombie_hurt_player.play()

func play_player_heal_sound() -> void:
	if _player_heal_player:
		_jitter_pitch(_player_heal_player, 1.0, 0.03)
		_player_heal_player.play()
