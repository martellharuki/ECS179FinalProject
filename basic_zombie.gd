class_name BasicZombie
extends CharacterBody2D

@export var speed: float = 80.0
@export var max_health: int = 30

var health: int
var stunned: bool = false

@onready var _hitbox: Area2D = $Sprite2D/Hitbox
@onready var _stun_timer: Timer = $Sprite2D/Stun_Timer
@onready var _sprite: Sprite2D = $Sprite2D
@onready var _nav_agent: NavigationAgent2D = $NavigationAgent2D

var _player: Player

func _ready() -> void:
	health = max_health

	# Find player via group defined in World.tscn
	_player = get_tree().get_first_node_in_group("player") as Player

func _physics_process(delta: float) -> void:
	if stunned or _player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	# no pathfinding version
	#var dir: Vector2 = (_player.global_position - global_position).normalized()
	
	_nav_agent.target_position = _player.global_position
	var next_point: Vector2 = _nav_agent.get_next_path_position()
	var dir: Vector2 = (next_point - global_position).normalized()
	
	velocity = dir * speed
	move_and_slide()
	
	if velocity.length() > 0.1:
		rotation = velocity.angle() + PI / 2.0

func _on_hitbox_area_entered(area: Area2D) -> void:
	var bullet := area.get_parent() as Bullet
	if bullet == null:
		return
	
	_take_damage(int(bullet.damage))
	
	_stun()
	_spawn_hit_particles(bullet.global_position)
	
	if bullet.has_method("delete_entity"):
		bullet.delete_entity()

func _stun() -> void:
	stunned = true
	_stun_timer.start()

func _on_stun_timer_timeout() -> void:
	stunned = false

func _take_damage(amount: int) -> void:
	health -= amount
	print("Zombie took damage: ", amount, " | health now: ", health)
	if health <= 0:
		queue_free()

func _spawn_hit_particles(hit_position: Vector2) -> void:
	# TODO: instance a particle scene here later
	pass
