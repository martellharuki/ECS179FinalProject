extends Node2D
##
## Cross cursor that replaces the mouse.
##

@export_group("Appearance")
@export var color: Color = Color.WHITE
@export var bar_thickness: float = 3.0
@export var bar_length: float = 12.0
@export var gap_radius: float = 8.0
@export var antialias: bool = true
@export var show_center_dot: bool = false
@export var center_dot_radius: float = 1.5

@export var hide_system_cursor: bool = true
@export var follow_in_ui_space: bool = true
# If true (default): the crosshair lives in the UI layer and ignores camera zoom/offset.
# If false: it will follow the mouse in WORLD space (scales with camera zoom).


func _ready() -> void:
	if hide_system_cursor:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_process(true)
	queue_redraw()


func _process(_delta: float) -> void:
	# Position the crosshair at the mouse each frame.
	if follow_in_ui_space:
		# UI (viewport) coords — perfect for HUD crosshair
		global_position = get_viewport().get_mouse_position()
	else:
		# World coords — if you want the crosshair to scale with the camera
		global_position = get_global_mouse_position()


func _draw() -> void:
	# We draw four bars around the origin, leaving an empty circle of radius = gap_radius.
	var r : float = max(0.0, gap_radius)
	var len : float = max(0.0, bar_length)
	var w : float = max(1.0, bar_thickness)

	# Right bar: from inner edge of gap to tip
	draw_line(Vector2(r, 0), Vector2(r + len, 0), color, w)
	# Left bar
	draw_line(Vector2(-r, 0), Vector2(-r - len, 0), color, w)
	# Up bar
	draw_line(Vector2(0, -r), Vector2(0, -r - len), color, w)
	# Down bar
	draw_line(Vector2(0, r), Vector2(0, r + len), color, w)

	# Optional center dot
	if show_center_dot and center_dot_radius > 0.0:
		draw_circle(Vector2.ZERO, center_dot_radius, color)
