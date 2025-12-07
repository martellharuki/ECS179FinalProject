class_name ItemBase
extends LiveEntity

@export var lifetime:float = 30
enum ItemType {
	gun,
	scrap
}
@export var item_type:ItemType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_time_lifespan(lifetime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
