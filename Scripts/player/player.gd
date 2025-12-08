class_name Player
extends CharacterBody2D

# Movement speed
@export var speed = 300.0
@export var max_health = 100.0

@onready var _weapon: WeaponHandler = $Weapon
@onready var _crafting_handler: CraftingHandler = $CraftingHandler

var facing_direction: Vector2
var current_health: float

func _ready():
	# Make sure player is affected by pause
	process_mode = Node.PROCESS_MODE_PAUSABLE
	z_index = 3
	
	# Initialize health
	current_health = max_health
	
	# Make it so player has base weapon
	var _initial_gun_spec = WeaponSpec.new(10, 6, 300, 0.2)
	_weapon.set_weapon(_initial_gun_spec)

func _physics_process(delta):
	# Get input direction
	var input_direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		input_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		input_direction.y += 1
	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
	
	if Input.is_action_pressed("left_click"):
		_handle_weapon_cmd()
	
	# Normalize so diagonal movement isn't faster
	input_direction = input_direction.normalized()
	
	if not _crafting_handler.locking_player_movement:
		velocity = input_direction * speed
	else:
		velocity = Vector2(0, 0)
	
	_face_mouse()
	
	move_and_slide()
	
	# FOR TEST
	if Input.is_action_just_pressed("win"):
		ScreenManager.show_win_screen()

func _face_mouse() -> void:
	# Get mouse global coordinates
	var mouse_global := get_global_mouse_position()
	
	# Rotate the player character to face the mouse.
	look_at(mouse_global)
	# Rotates the model to the wanted direction
	rotation += deg_to_rad(90)

func _handle_weapon_cmd() -> void:
	var _mouse_location: Vector2 = get_global_mouse_position() - self.global_position
	var _direction = _mouse_location.normalized()
	
	_weapon.handle_weapon_fire(_direction)

func heal(amount: float):
	current_health = min(max_health, current_health + amount)
	
	# Find HP bar and update it
	var hp_bar = get_tree().get_first_node_in_group("hp_bar")
	if hp_bar and hp_bar.has_method("update_player_health"):
		hp_bar.update_player_health(current_health, max_health)


func take_damage(amount: float):
	current_health = max(0, current_health - amount)
	
	# Find HP bar and update it
	var hp_bar = get_tree().get_first_node_in_group("hp_bar")
	if hp_bar and hp_bar.has_method("update_player_health"):
		hp_bar.update_player_health(current_health, max_health)
	
	# Check if player died
	if current_health <= 0:
		player_died()

func player_died():
	ScreenManager.show_lose_screen()
