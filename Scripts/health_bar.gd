extends Control

@onready var background = $HealthBarContainer/Background
@onready var fill = $HealthBarContainer/Background/Fill
@onready var shine = $HealthBarContainer/Background/Fill/Shine

var max_health = 100.0
var current_health = 100.0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	setup_health_bar_style()
	update_health_bar()

func setup_health_bar_style():
	# background with border
	var bg_style = StyleBoxFlat.new()
	bg_style.bg_color = Color(0.1, 0.1, 0.12)
	bg_style.set_corner_radius_all(6)
	bg_style.set_border_width_all(2)
	bg_style.border_color = Color(0.2, 0.2, 0.22)
	background.add_theme_stylebox_override("panel", bg_style)
	
	# fill bar
	var fill_style = StyleBoxFlat.new()
	fill_style.bg_color = Color(0.18, 0.8, 0.44)
	fill_style.set_corner_radius_all(4)
	fill.add_theme_stylebox_override("panel", fill_style)
	
	# shine effect 
	var shine_style = StyleBoxFlat.new()
	shine_style.bg_color = Color(1, 1, 1, 0.15)
	shine_style.corner_radius_top_left = 3
	shine_style.corner_radius_top_right = 3
	shine.add_theme_stylebox_override("panel", shine_style)

# Called by the player when they take damage
func update_player_health(new_current: float, new_max: float):
	current_health = new_current
	max_health = new_max
	update_health_bar()

func update_health_bar():
	var health_percent = current_health / max_health
	
	# Smooth animation
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(fill, "scale:x", health_percent, 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	# Color changes based on health
	var target_color: Color
	if health_percent > 0.6:
		target_color = Color(0.18, 0.8, 0.44)
	elif health_percent > 0.3:
		target_color = Color(0.95, 0.61, 0.07)
	else:
		target_color = Color(0.86, 0.2, 0.2)
	
	# Update the fill color
	var fill_style = fill.get_theme_stylebox("panel")
	if fill_style:
		tween.tween_property(fill_style, "bg_color", target_color, 0.25)
