extends CharacterBody2D

# Movement speed
@export var speed = 300.0

@onready var _weapon:WeaponHandler = $Weapon

var facing_direction:Vector2 

func _ready():
	# Make sure player is affected by pause
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	#make it so player has base weapon
	var _initial_gun_spec = WeaponSpec.new(6, 500, 300, 0.2)
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
	
	velocity = input_direction * speed
	
	
	_face_mouse()
	
	
	
	move_and_slide()


func _face_mouse() -> void:
	# Get mouse global coordinates
	var mouse_global := get_global_mouse_position()
	
	# Rotate the player character to face the mouse.
	look_at(mouse_global)

	# Rotates the model to the wanted direction
	rotation += deg_to_rad(90)

func _handle_weapon_cmd() -> void:
	var _mouse_location:Vector2 = get_global_mouse_position() - self.global_position
	var _direction = _mouse_location.normalized()
	
	_weapon.handle_weapon_fire(_direction)
