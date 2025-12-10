extends Camera2D

@export var lead_speed: float = 800.0
@export var leash_distance: float = 160.0
@export var max_dist: float = 300.0
@export var max_speed: float = 300.0

const MIN_SPEED_FACTOR: float = 0.45

@onready var player: Node2D = get_parent() as Node2D

func _ready() -> void:
	set_as_top_level(true)

	if player:
		global_position = player.global_position
	global_rotation = 0.0
	

func _physics_process(delta: float) -> void:
	if player == null:
		return

	var player_pos := player.global_position
	var mouse_pos := get_global_mouse_position()

	# Lead target: player -> mouse (clamped so it never exceeds leash)
	var to_mouse := mouse_pos - player_pos
	var desired_offset := Vector2.ZERO

	var lead_limit : float = min(leash_distance, max_dist)
	if to_mouse.length_squared() > 0.001:
		desired_offset = to_mouse
		var desired_len := desired_offset.length()
		if desired_len > lead_limit:
			desired_offset = desired_offset / desired_len * lead_limit

	# Current offset: player -> camera
	var current_offset := global_position - player_pos

	# Camera slows as it gets farther from player, until leash_distance
	var slowdown_radius : float = max(leash_distance, 0.001)
	var ratio : float = clamp(current_offset.length() / slowdown_radius, 0.0, 1.0)
	var speed_factor : float = max(MIN_SPEED_FACTOR, 1.0 - ratio)
	var max_step : float = lead_speed * speed_factor * delta

	# Smoothly move offset toward desired_offset using a step-limited lerp
	var to_target := desired_offset - current_offset
	var dist := to_target.length()
	if dist > 0.001:
		var t : float = min(1.0, max_step / dist)
		current_offset = current_offset.lerp(desired_offset, t)
	else:
		current_offset = desired_offset

	# Max leash distance
	var hard_radius : float = max(max_dist, 0.001)
	var offset_len := current_offset.length()
	if offset_len > hard_radius:
		current_offset = current_offset / offset_len * hard_radius

	var desired_camera_pos := player_pos + current_offset

	var displacement := desired_camera_pos - global_position
	var distance := displacement.length()

	# Max camera speed
	if distance > 0.001:
		var max_move := max_speed * delta
		if distance > max_move:
			displacement = displacement / distance * max_move
		global_position += displacement
	else:
		global_position = desired_camera_pos

	var actual_offset := global_position - player_pos
	var actual_distance := actual_offset.length()

	if actual_distance > max_dist and actual_distance > 0.001:
		global_position = player_pos + (actual_offset / actual_distance) * max_dist

	global_rotation = 0.0
