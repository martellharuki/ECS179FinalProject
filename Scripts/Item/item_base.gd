class_name ItemBase
extends LiveEntity

var _item_spawner:ItemSpawner

enum ItemType {
	gun,
	scrap,
	bandage
}
@export var item_type:ItemType

var index:int 

func set_index_and_location(_index:int, location:Vector2, _item_spawning_instance:ItemSpawner) -> void:
	index = _index 
	global_position = location
	_item_spawner = _item_spawning_instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _life_span == LifeSpan.TIME:
		if _timer == null or _timer.is_stopped():
			_item_spawner.notify_deleted_item(index)
			
	super._process(delta)
	
func delete_entity():
	_item_spawner.notify_deleted_item(index)
	
	super.delete_entity()
