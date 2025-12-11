class_name LumpZombie
extends BasicZombie

# --- Zig-zag movement settings ---
@export var base_speed: float = 120.0
@export var zigzag_amplitude: float = 0.7      # sideways strength
@export var zigzag_frequency: float = 2.5      # wiggles per second

# attack animations we can randomly pick from
var _attack_anims: Array[StringName] = [
	&"attack1",
	&"attack2"
]

var _time_accum: float = 0.0


func _physics_process(delta: float) -> void:
	if stunned or _player == null or _dying:
		velocity = Vector2.ZERO
		move_and_slide()
		_update_animation()
		return

	_time_accum += delta

	var to_player: Vector2 = _player.global_position - global_position
	var dist: float = to_player.length()

	if dist > stop_distance:
		# forward vector towards player
		var forward: Vector2 = to_player.normalized()

		# perpendicular (sideways) vector
		var side: Vector2 = Vector2(-forward.y, forward.x)

		# sine-wave sideways offset
		var zigzag: Vector2 = side * sin(_time_accum * TAU * zigzag_frequency) * zigzag_amplitude

		var dir: Vector2 = (forward + zigzag).normalized()
		velocity = dir * base_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if dist <= attack_range and can_attack:
		_attack_player()

	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		if collision.get_collider() is Player and can_attack:
			_attack_player()
			break

	if velocity.length() > 0.1:
		rotation = velocity.angle() + 3.0 * PI / 2.0

	_update_animation()


# --- Random attack animation ---
func _attack_player() -> void:
	if _player and can_attack and not _dying:
		can_attack = false
		_attacking = true

		if _sprite:
			# pick attack1 or attack2 at random
			var idx := randi_range(0, _attack_anims.size() - 1)
			var anim: StringName = _attack_anims[idx]

			if _sprite:
				_sprite.play(anim)
			else:
				# fallback if something is mis-named
				if _sprite.has_animation(&"attack1"):
					_sprite.play(&"attack1")

		_player.take_damage(damage)
		_attack_timer.start()


func _on_animation_finished() -> void:
	if _sprite == null:
		return

	var anim := _sprite.animation

	if anim.begins_with("attack"):
		_attacking = false
	elif anim == "death":
		queue_free()
