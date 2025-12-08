#class_name BandageHandler
#extends Node
#
#@export var _craft_time:float
#@export var _scrap_needed_to_craft:int
#@onready var _action_item:ActionItem = %ActionItem
#
#var _scrap_count:int = 0
#var _craft_progress:float = 0
#
#func pick_up_scrap() -> void:
	#_scrap_count += 1
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if _scrap_count < _scrap_needed_to_craft:
		#return
	#
	#if Input.is_action_pressed("bandage"):
		##heal(20)
		#_craft_progress += delta
		#var ratio:float = clampf(_craft_progress / _craft_time, 0, 1)
		#_action_item.set_action_bar(ratio, ActionItem.BarType.crafting)
	#else:
		#_craft_progress = 0
		#_action_item.conclude_action_bar(ActionItem.BarType.crafting)
	#
	#if _craft_progress >= _craft_time:
		#print("Crafting!")
		#_scrap_count -= _scrap_needed_to_craft
		#UpgradeSpec.upgrade_spec.upgrade_random()
		#
		#_craft_progress = 0
		#_action_item.conclude_action_bar(ActionItem.BarType.crafting)
	
