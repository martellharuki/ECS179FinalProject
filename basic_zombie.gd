class_name BasicZombie
extends CharacterBody2D

@export var speed: float = 80.0
@export var max_health: int = 30
@export var damage: float = 10.0
@export var attack_cooldown: float = 1.0

@export var stop_distance: float = 65.0
@export var attack_range: float = 70.0

var health: int
var stunned: bool = false
var can_attack: bool = true
var _dying: bool = false

@onready var _hitbox: Area2D = $Sprite2D/Hitbox
@onready var _stun_timer: Timer = $Sprite2D/Stun_Timer
@onready var _sprite: AnimatedSprite2D = $Sprite2D
@onready var _nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var _attack_timer: Timer = Timer.new()
@onready var _item_spawner: ItemSpawner = %ItemSpawner

var _player: Player

func _ready() -> void:
	health = max_health
	
	_player = get_tree().get_first_node_in_group("player") as Player
	
	add_child(_attack_timer)
	_attack_timer.wait_time = attack_cooldown
	_attack_timer.one_shot = true
	_attack_timer.timeout.connect(_on_attack_timer_timeout)
	
	_sprite.speed_scale = 1.0
	_sprite.play("walk")

func _physics_process(delta: float) -> void:
	if stunned or _player == null or _dying:
		velocity = Vector2.ZERO
		move_and_slide()
		_update_animation()
		return

	var to_player: Vector2 = _player.global_position - global_position
	var dist: float = to_player.length()

	# --- MOVEMENT: stop before we shove the player around ---
	if dist > stop_distance:
		_nav_agent.target_position = _player.global_position
		var next_point: Vector2 = _nav_agent.get_next_path_position()
		var dir: Vector2 = (next_point - global_position).normalized()
		velocity = dir * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if dist <= attack_range and can_attack:
		_attack_player()

	# optional: keep old collision-based attack as backup
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is Player and can_attack:
			_attack_player()
			break

	if velocity.length() > 0.1:
		rotation = velocity.angle() + PI / 2.0
		
	_update_animation()

func _attack_player() -> void:
	if _player and can_attack and not _dying:
		if _sprite:
			_sprite.play("attack")
		_player.take_damage(damage)
		can_attack = false
		_attack_timer.start()

func _on_attack_timer_timeout() -> void:
	can_attack = true

func _on_hitbox_area_entered(area: Area2D) -> void:
	if _dying:
		return
	
	var bullet := area.get_parent() as Bullet
	if bullet == null:
		return
	
	_take_damage(int(bullet.damage))
	_sprite.modulate = Color(1.0, 0.3, 0.3)
	
	_stun()
	_spawn_hit_particles(bullet.global_position)
	
	if bullet.has_method("delete_entity"):
		bullet.delete_entity()

func _stun() -> void:
	stunned = true
	_stun_timer.start()

func _on_stun_timer_timeout() -> void:
	stunned = false
	_sprite.modulate = Color(1.0, 1.0, 1.0)

func _take_damage(amount: int) -> void:
	if _dying:
		return
	
	health -= amount
	print("Zombie took damage: ", amount, " | health now: ", health)
	
	if health > 0:
		return
		
	_dying = true
	velocity = Vector2.ZERO
	$Physic_CollisionShape2D.disabled = true
	_hitbox.monitoring = false
	
	#if health <= 0:
	var hud = get_tree().get_first_node_in_group("hud")
	if hud and hud.has_method("add_score"):
		hud.add_score(10)
		
	_item_spawner.handle_scrap_spawn(global_position)
	
	if _sprite:
		_sprite.play("death")
		_sprite.animation_finished.connect(_on_death_animation_finished, CONNECT_ONE_SHOT)
	else:
		queue_free()
	#queue_free()

func _on_death_animation_finished() -> void:
	if _sprite.animation != "death":
		return
	queue_free()

func _spawn_hit_particles(hit_position: Vector2) -> void:
	# TODO: particles later
	pass

func set_stats(new_max_health: int) -> void:
	max_health = new_max_health
	health = new_max_health

func set_item_spawner(_item_spawner_ref: ItemSpawner) -> void:
	_item_spawner = _item_spawner_ref

func _update_animation() -> void:
	if _dying:
		return
	if stunned:
		return
	if velocity.length() > 10.0:
		if _sprite.animation != "walk":
			_sprite.play("walk")
		else:
			if _sprite.animation != "walk":
				_sprite.play("walk")
			_sprite.stop()
			_sprite.frame = 0
			
