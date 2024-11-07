extends NpcState


var timer : Timer
var callback

func _ready() -> void:
	super()
	timer = get_children(true).filter(func(n) : return n.name == 'Timer')[0]
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	if callback:
		callback.call()


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	if _message.has("duration"):
		timer.wait_time = _message["duration"]
		timer.start()
