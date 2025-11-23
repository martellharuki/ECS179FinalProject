class_name Entity
extends Node2D

@onready var _mesh:Sprite2D = $VisualSprite

func hide_entity():
	_mesh.visible = false

func show_mesh():
	_mesh.visible = true

func delete_entity():
	queue_free()
