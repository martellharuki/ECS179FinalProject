class_name ItemPickup
extends Node

@export var _pick_up_time: float = 0.6
@export var _pickup_anim_y_offset: float = 12.0 

@onready var _player: Player = %Player
@onready var _crafting_handler: CraftingHandler = %CraftingHandler
@onready var _bandage_handler: BandageHandler = %BandageHandler
@onready var _area: ItemCollision = $Area2D
@onready var _action_item: ActionItem = %ActionItem
@onready var _pickup_anim: AnimatedSprite2D = $PickUpAnimation

const PICKUP_ANIM_NAME: StringName = &"pick_up"

var _progress: float = 0.0
var _action_type: ActionItem.BarType = ActionItem.BarType.pickup
var _hover_item: ItemBase = null
var _pickup_anim_speed: float = 1.0

func _ready() -> void:
	if _pickup_anim == null:
		push_error("PickUpAnimation node not found. Fix the path to $PickUpAnimation.")
		return

	_pickup_anim.visible = false
	_pickup_anim.animation_finished.connect(_on_pickup_anim_finished)

func handle_item_hover(body, delta: float) -> void:
	var item: ItemBase = body.get_parent() as ItemBase
	if item == null:
		return

	if _hover_item != item:
		_hover_item = item
		_progress = 0.0
		_start_pickup_vfx(item)

	_update_pickup_vfx_pos(item)

	_progress += delta

	if _progress >= _pick_up_time:
		_action_item.conclude_action_bar(_action_type)

		if item.item_type == ItemBase.ItemType.scrap:
			_crafting_handler.pick_up_scrap()
		elif item.item_type == ItemBase.ItemType.gun:
			_player.pick_up_gun(item.get_gun_type())
		elif item.item_type == ItemBase.ItemType.bandage:
			_bandage_handler.add_bandage(1)

		_area.reset(body)
		item.delete_entity()

		_progress = 0.0
		_hover_item = null
	else:
		var ratio: float = _progress / _pick_up_time
		_action_item.set_action_bar(ratio, _action_type)

func handle_item_exit() -> void:
	_action_item.conclude_action_bar(_action_type)
	_progress = 0.0
	_hover_item = null
	_stop_pickup_vfx()

func _start_pickup_vfx(item: ItemBase) -> void:
	if _pickup_anim == null:
		return

	_pickup_anim_speed = _compute_speed_to_match_time(PICKUP_ANIM_NAME, _pick_up_time)
	_pickup_anim.visible = true
	_pickup_anim.set_frame_and_progress(0, 0.0)
	_update_pickup_vfx_pos(item)


	_pickup_anim.play(PICKUP_ANIM_NAME, _pickup_anim_speed)

func _update_pickup_vfx_pos(item: ItemBase) -> void:
	if _pickup_anim == null:
		return
	_pickup_anim.global_position = item.global_position + Vector2(0.0, -_pickup_anim_y_offset)

func _stop_pickup_vfx() -> void:
	if _pickup_anim == null:
		return
	_pickup_anim.visible = false
	_pickup_anim.stop()

func _on_pickup_anim_finished() -> void:

	if _hover_item == null:
		_stop_pickup_vfx()

func _compute_speed_to_match_time(anim_name: StringName, desired_time: float) -> float:

	if _pickup_anim == null or desired_time <= 0.0:
		return 1.0

	var sf: SpriteFrames = _pickup_anim.sprite_frames
	if sf == null or not sf.has_animation(anim_name):
		return 1.0

	var fps: float = sf.get_animation_speed(anim_name)
	if fps <= 0.0:
		return 1.0

	var frame_count: int = sf.get_frame_count(anim_name)
	if frame_count <= 0:
		return 1.0

	var sum_rel: float = 0.0
	for i in range(frame_count):
		sum_rel += sf.get_frame_duration(anim_name, i)

	var base_duration: float = sum_rel / fps
	if base_duration <= 0.0:
		return 1.0

	return base_duration / desired_time
