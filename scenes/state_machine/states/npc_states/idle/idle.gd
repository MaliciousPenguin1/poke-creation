extends NpcState


var duration : float = 0
var timer : Timer
var callback : Callable

func _ready() -> void:
	timer = get_children(true).filter(func(n) : return n.name == 'Timer')[0]
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout(delta: float) -> void:
	if callback:
		callback.call()


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	timer.wait_time = _message["duration"] if _message.has("duration") else duration
	timer.start()
