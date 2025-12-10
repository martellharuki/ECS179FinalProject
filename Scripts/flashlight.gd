extends PointLight2D


const TEXTURE_SIZE_PX: int = 256
const FLASHLIGHT_ANGLE_DEG: float = 25.0
const EDGE_SOFTNESS_DEG: float = 12.0
const FALLOFF_POWER: float = 1


const ORIGIN_FORWARD_DISTANCE: float = 16.0

@onready var player := get_parent() as Node2D


func _ready() -> void:
	texture = _generate_flashlight_cone(
		TEXTURE_SIZE_PX,
		deg_to_rad(FLASHLIGHT_ANGLE_DEG),
		deg_to_rad(EDGE_SOFTNESS_DEG),
		FALLOFF_POWER
	)

	color = Color(1.0, 0.965, 0.85)
	energy = 1.6
	texture_scale = 1.4
	shadow_enabled = false
	offset = Vector2.ZERO


func _process(_delta: float) -> void:
	if player == null:
		return

	var player_pos: Vector2 = player.global_position
	var mouse_pos: Vector2 = get_global_mouse_position()
	var to_mouse: Vector2 = mouse_pos - player_pos

	if to_mouse.length_squared() == 0.0:
		return

	var dir_to_mouse: Vector2 = to_mouse.normalized()

	global_rotation = dir_to_mouse.angle()
	
	global_position = player_pos + dir_to_mouse * ORIGIN_FORWARD_DISTANCE


func _generate_flashlight_cone(
		texture_size: int,
		cone_angle_rad: float,
		edge_softness_rad: float,
		falloff_power: float
	) -> Texture2D:

	var size: int = max(64, (texture_size | 1)) # make sure odd and >= 64
	var image := Image.create(size, size, false, Image.FORMAT_RGBA8)

	var bulb_position := Vector2(0.5 * size, 0.5 * size)
	var max_radius := 0.48 * size

	var half_angle := cone_angle_rad * 0.5
	var soft_start := half_angle
	var soft_end : float = half_angle + max(0.001, edge_softness_rad)

	for y in range(size):
		for x in range(size):
			var to_pixel := Vector2(x, y) - bulb_position

			if to_pixel.x <= 0.0:
				continue

			# Angle from the forward (+X) direction.
			var angle_from_forward: float = abs(wrapf(to_pixel.angle(), -PI, PI))

			var angular_mask := 1.0 - _smoothstep(soft_start, soft_end, angle_from_forward)
			if angular_mask <= 0.0:
				continue

			var distance_ratio := to_pixel.length() / max_radius
			var radial_mask := pow(clamp(1.0 - distance_ratio, 0.0, 1.0), falloff_power)

			var alpha: float = clamp(angular_mask * radial_mask, 0.0, 1.0)
			if alpha > 0.0:
				image.set_pixel(x, y, Color(1, 1, 1, alpha))

	return ImageTexture.create_from_image(image)


func _smoothstep(edge0: float, edge1: float, x: float) -> float:
	var t: float = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
	return t * t * (3.0 - 2.0 * t)
