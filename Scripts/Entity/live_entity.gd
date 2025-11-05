class_name LiveEntity
extends Entity

enum LifeSpan{
	UNINIT,
	HEALTH,
	TIME,
	BOTH
}

var _life_span:LifeSpan = LifeSpan.UNINIT
var _max_health:float
var _curr_health:float
var _timer:Timer

func set_health_lifespan(_health:float):
	_max_health = _health
	_curr_health = _health
	_life_span = LifeSpan.HEALTH
	
func set_time_lifespan(_duration:float):
	_timer = Timer.new()
	add_child(_timer)
	_timer.one_shot = true
	_timer.start(_duration)
	_life_span = LifeSpan.TIME

func set_health_time_lifespan(_health:float, _duration:float):
	set_health_lifespan(_health)
	set_time_lifespan(_duration)
	_life_span = LifeSpan.BOTH

func _process(_delta:float):
	match _life_span:
		LifeSpan.HEALTH:
			if _curr_health < _max_health:
				delete_entity()
		LifeSpan.TIME:
			if _timer == null or _timer.is_stopped():
				delete_entity()
		LifeSpan.BOTH:
			if _timer == null or _timer.is_stopped() or _curr_health < _max_health:
				delete_entity()
