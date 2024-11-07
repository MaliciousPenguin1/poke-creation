extends Compass_Instruction
class_name Compass_Wait


@export var duration : float


var timer : Timer


func _ready() -> void:
	super()
	timer = get_children(true).filter(func(n) : return n.name == 'Timer')[0]
	timer.wait_time = duration
	timer.timeout.connect(after_consumed_callback)


func consume(_object_to_instruct) -> void:
	timer.start()
