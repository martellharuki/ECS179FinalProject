class_name Audio_Handler
extends Node2D


@onready var _gun_shot_player:AudioStreamPlayer2D = $Gunshot
var _is_shooting:bool = false

func play_gunshot_sound() -> void:
	if not _is_shooting:
		_gun_shot_player.play()
		_is_shooting = true
	
func stop_gunshot_sound() -> void:
	if _is_shooting:
		_gun_shot_player.stop()
		_is_shooting = false
