class_name ActionItem
extends Node2D

@export var max_width:float
@export var _text_display_duration:float = 0.3
@onready var bar:ProgressBar = $Bar
@onready var _label:Label = $Label
@onready var _player:Player = %Player

var curr_extension:float = 0
var curr_type:BarType = BarType.none
var _text_timer:Timer = Timer.new()

enum BarType {
	none,
	crafting,
	pickup
}

func _ready() -> void:
	_text_timer = Timer.new()
	_text_timer.one_shot = true
	add_child(_text_timer)
		
func _process(delta: float) -> void:
	global_position = _player.global_position
	
	if (_text_timer.is_stopped()):
		_label.text = ""

func set_action_bar(ratio:float, bar_type:BarType) -> void:
	if bar_type != curr_type:
		if curr_type == BarType.none:
			curr_type = bar_type
		elif bar_type == BarType.crafting and curr_type == BarType.pickup:
			curr_type = bar_type
		else:
			return
	
	ratio = clamp(ratio, 0.0, 1.0)
	bar.value = ratio

func conclude_action_bar(bar_type:BarType) -> void:
	if bar_type != curr_type:
		if curr_type == BarType.crafting and bar_type == BarType.pickup:
			return
	
	bar.value = 0
	curr_type = BarType.none
	
func set_text(prompt:String) -> void:
	if _text_timer.is_stopped():
		_text_timer.start()
	else:
		_text_timer.stop()
		_text_timer.start()
		
	_label.text = prompt
