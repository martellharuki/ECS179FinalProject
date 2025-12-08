class_name ItemCollision
extends Area2D

var _item_handler:ItemPickup
var _is_entered:bool = false
var _hovered_body = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_item_handler = get_parent()
	area_entered.connect(_collider_entered)
	area_exited.connect(_collider_exited)

func reset():
	_is_entered = false
	_hovered_body = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _is_entered:
		_item_handler.handle_item_hover(_hovered_body, delta)

func _collider_entered(body) -> void:
	if not body.is_in_group("item"):
		print("Not in item: ")
		return
	
	print("Collider entered")
	_is_entered = true
	_hovered_body = body

func _collider_exited(body) -> void:
	if not body.is_in_group("item"):
		return
	
	_is_entered = false
	_hovered_body = null
	_item_handler.handle_item_exit()
