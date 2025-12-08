class_name ScissorZombie
extends BasicZombie

enum State { CHASE, WINDUP, CHARGE, RECOVER }

@export var boss_max_health: int = 300
@export var boss_damage: float = 30.0
@export var chase_speed: float = 90.0
@export var charge_speed: float = 900.0
@export var trigger_range: float = 600.0
@export var windup_time: float = 0.6
@export var charge_time: float = 0.35
@export var recover_time: float = 0.6

var _state: State = State.CHASE
var _charge_dir: Vector2 = Vector2.ZERO
var _boss_active: bool = true   # boss now active immediately

@onready var _windup_timer: Timer = $WindupTimer
@onready var _charge_timer: Timer = $ChargeTimer
@onready var _recover_timer: Timer = $RecoverTimer

func _ready() -> void:
	max_health = boss_max_health
	damage = boss_damage
	
	super._ready()
	
	_windup_timer.timeout.connect(_on_windup_timeout)
	_charge_timer.timeout.connect(_on_charge_timeout)
	_recover_timer.timeout.connect(_on_recover_timeout)

func _take_damage(amount: int) -> void:
	health -= amount
	
	if health <= 0:
		var hud = get_tree().get_first_node_in_group("hud")
		if hud and hud.has_method("add_score"):
			hud.add_score(200)
		
		ScreenManager.show_win_screen()
		
		if _item_spawner:
			_item_spawner.handle_scrap_spawn(global_position)
		
		queue_free()

func _physics_process(delta: float) -> void:
	if not _boss_active:
		return
		
	if stunned or _player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	match _state:
		State.CHASE:
			_do_chase()
		State.WINDUP:
			velocity = Vector2.ZERO
			move_and_slide()
		State.CHARGE:
			velocity = _charge_dir * charge_speed
			move_and_slide()
			_check_charge_attack()
		State.RECOVER:
			velocity = Vector2.ZERO
			move_and_slide()
	
	if velocity.length() > 0.1:
		rotation = velocity.angle() + PI / 2.0

func _do_chase() -> void:
	_nav_agent.target_position = _player.global_position
	var next_point: Vector2 = _nav_agent.get_next_path_position()
	var dir: Vector2 = (next_point - global_position).normalized()
	
	velocity = dir * chase_speed
	move_and_slide()
	
	if global_position.distance_to(_player.global_position) <= trigger_range and can_attack:
		_start_windup()

func _start_windup() -> void:
	_state = State.WINDUP
	_charge_dir = (_player.global_position - global_position).normalized()
	_windup_timer.start(windup_time)

func _on_windup_timeout() -> void:
	_state = State.CHARGE
	set_collision_mask_value(2, false)
	_charge_timer.start(charge_time)

func _on_charge_timeout() -> void:
	_end_charge()

func _on_recover_timeout() -> void:
	_state = State.CHASE
	can_attack = true

func _end_charge() -> void:
	set_collision_mask_value(2, true)
	_state = State.RECOVER
	_recover_timer.start(recover_time)

func _check_charge_attack() -> void:
	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		if collision.get_collider() is Player and can_attack:
			_attack_player()
			_end_charge()
			break
