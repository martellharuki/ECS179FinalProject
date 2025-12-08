class_name ItemPickup
extends Node

@export var _pick_up_time:float
@onready var _player:Player = %Player
@onready var _crafting_handler:CraftingHandler = %CraftingHandler
@onready var _area:ItemCollision = $Area2D
@onready var _action_item:ActionItem = %ActionItem

var _progress:float
var _action_type:ActionItem.BarType = ActionItem.BarType.pickup
	
func handle_item_hover(body, delta:float) -> void:
	_progress += delta
	if _progress >= _pick_up_time:
		_action_item.conclude_action_bar(_action_type)
		var item:ItemBase = body.get_parent()
		if item.item_type == ItemBase.ItemType.scrap:
			_crafting_handler.pick_up_scrap()
		elif item.item_type == ItemBase.ItemType.gun:
			_player.pick_up_gun(body.get_parent().get_gun_type())
		_area.reset(body)
		item.delete_entity()
		_progress = 0
	else:
		var _ratio:float = _progress / _pick_up_time
		_action_item.set_action_bar(_ratio, _action_type)

func handle_item_exit() -> void:
	_action_item.conclude_action_bar(_action_type)
	_progress = 0
