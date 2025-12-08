class_name BulletArea
extends Area2D

var parent_bullet:Bullet

func _ready() -> void:
	parent_bullet = get_parent()
	body_entered.connect(_on_bullet_entered)
	
func _on_bullet_entered(body) -> void:
	if parent_bullet:
		parent_bullet.handle_bullet_collision(body)
