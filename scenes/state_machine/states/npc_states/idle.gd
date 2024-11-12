extends NpcState
class_name NpcStateIdle


func _on_timer_timeout() -> void:
	if callback:
		callback.call()


func enter(_message : Dictionary = {}) -> void:
	super()
	callback = _message["callback"] if _message.has("callback") else null
	if _message.has("duration"):
		await get_tree().create_timer(_message["duration"], false).timeout
		_on_timer_timeout()
