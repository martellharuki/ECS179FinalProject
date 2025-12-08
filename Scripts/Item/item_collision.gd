class_name ItemCollision
extends Area2D

var _item_handler:ItemPickup
var _body_list:Array[Area2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_item_handler = get_parent()
	area_entered.connect(_collider_entered)
	area_exited.connect(_collider_exited)

func reset(body):
	if (len(_body_list) == 0): return
	_remove_value(body)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(_body_list) > 0:
		_item_handler.handle_item_hover(_body_list[0], delta)

func _collider_entered(body) -> void:
	if not body.is_in_group("item"):
		print("Not in item: ")
		return
	
	print("Collider entered: " + str(len(_body_list)))
	_body_list.append(body)

func _collider_exited(body) -> void:
	if not body.is_in_group("item"):
		return
	
	if (len(_body_list) == 0): return
	_remove_value(body)
	if (len(_body_list) == 0): _item_handler.handle_item_exit()

func _remove_value(body) -> void:
	for i in range(len(_body_list)):
		if _body_list[i] == body:
			_body_list.remove_at(i)
			return
