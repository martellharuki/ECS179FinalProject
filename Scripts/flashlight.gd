extends PointLight2D
##
## Flashlight: code-generated cone texture + positioning + aiming.
## Attach to a PointLight2D that is a child of the Player.
## The script:
##   - Makes the cone texture.
##   - Moves the light a bit in front of the player.
##   - Rotates it so it always points at the mouse.
##

# --- LIGHT TEXTURE PARAMETERS (shape of the cone) ---
const TEXTURE_SIZE_PX: int = 256           # 64–2048. Larger = smoother edges.
const FLASHLIGHT_ANGLE_DEG: float = 25.0   # Full spread angle of the cone.
const EDGE_SOFTNESS_DEG: float = 12.0      # Feather width at the sides of the cone.
const FALLOFF_POWER: float = 1           # >1 = faster fade with distance.

# --- ORIGIN PARAMETERS (where the light comes from relative to the player) ---
const ORIGIN_FORWARD_DISTANCE: float = 16.0   # pixels in front of the player
# (Increase this if you want the flashlight to start further away from the chest.)

# We'll treat the node's parent as "the player".
@onready var player := get_parent() as Node2D


func _ready() -> void:
	# 1) Generate the cone texture once and assign it.
	texture = _generate_flashlight_cone(
		TEXTURE_SIZE_PX,
		deg_to_rad(FLASHLIGHT_ANGLE_DEG),
		deg_to_rad(EDGE_SOFTNESS_DEG),
		FALLOFF_POWER
	)

	# 2) Basic light look.
	color = Color(1.0, 0.965, 0.85)  # warm-ish white
	energy = 1.6
	texture_scale = 1.4
	shadow_enabled = false           # enable after adding occluders
	offset = Vector2.ZERO            # no extra texture offset; bulb is centered


func _process(_delta: float) -> void:
	if player == null:
		return

	# --- Step 1: get important positions ---
	var player_pos: Vector2 = player.global_position
	var mouse_pos: Vector2 = get_global_mouse_position()
	var to_mouse: Vector2 = mouse_pos - player_pos

	if to_mouse.length_squared() == 0.0:
		return

	var dir_to_mouse: Vector2 = to_mouse.normalized()

	# --- Step 2: rotate the light so +X points at the mouse ---
	global_rotation = dir_to_mouse.angle()
	#   (We do NOT rely on the player's rotation, so your -90° offset no longer hurts us.)

	# --- Step 3: move the origin a bit in front of the player ---
	# The light will start ORIGIN_FORWARD_DISTANCE pixels along the beam direction.
	global_position = player_pos + dir_to_mouse * ORIGIN_FORWARD_DISTANCE


func _generate_flashlight_cone(
		texture_size: int,
		cone_angle_rad: float,
		edge_softness_rad: float,
		falloff_power: float
	) -> Texture2D:

	var size: int = max(64, (texture_size | 1)) # make sure odd and >= 64
	var image := Image.create(size, size, false, Image.FORMAT_RGBA8)

	# Bulb at the CENTER of the texture so the node position == light source.
	var bulb_position := Vector2(0.5 * size, 0.5 * size)
	var max_radius := 0.48 * size    # where intensity fades to zero

	var half_angle := cone_angle_rad * 0.5
	var soft_start := half_angle
	var soft_end : float = half_angle + max(0.001, edge_softness_rad)

	for y in range(size):
		for x in range(size):
			var to_pixel := Vector2(x, y) - bulb_position

			# Only light pixels in front of the bulb (toward +X).
			if to_pixel.x <= 0.0:
				continue

			# Angle from the forward (+X) direction.
			var angle_from_forward: float = abs(wrapf(to_pixel.angle(), -PI, PI))

			# Angular mask: 1 on the beam center, fading to 0 across the edge.
			var angular_mask := 1.0 - _smoothstep(soft_start, soft_end, angle_from_forward)
			if angular_mask <= 0.0:
				continue

			# Radial mask: fade with distance.
			var distance_ratio := to_pixel.length() / max_radius
			var radial_mask := pow(clamp(1.0 - distance_ratio, 0.0, 1.0), falloff_power)

			var alpha: float = clamp(angular_mask * radial_mask, 0.0, 1.0)
			if alpha > 0.0:
				image.set_pixel(x, y, Color(1, 1, 1, alpha))

	return ImageTexture.create_from_image(image)


func _smoothstep(edge0: float, edge1: float, x: float) -> float:
	var t: float = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
	return t * t * (3.0 - 2.0 * t)
