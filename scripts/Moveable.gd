extends PhysicsBody2D
class_name Moveable


const DEFAULT_MOVEMENT_DURATION : float = 1.0


var is_moving : bool = false
var current_state : State


func move(direction : Vector2, movement_duration : float = DEFAULT_MOVEMENT_DURATION) -> void: 
	var tween = create_tween()
	tween.tween_property(self, "position", self.position + direction*GlobalConstants.TILES_SIZE, movement_duration)
	tween.tween_callback(finish_movement)
	is_moving = true

func finish_movement() -> void:
	is_moving = false
	self.current_state.after_walk()

func can_move() -> bool:
	return !is_moving
