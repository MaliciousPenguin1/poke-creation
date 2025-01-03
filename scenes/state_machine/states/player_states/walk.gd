extends PlayerState
class_name PlayerStateWalk

var current_dir : Vector2i
var next_dir : Vector2i


func unhandled_input(_event: InputEvent) -> void:
		var direction_pressed : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		next_dir = Vector2i(direction_pressed.sign())


func process(_delta: float) -> void:
	if player.moveable_component.can_move():
		var target_position : Vector2i = Vector2i(player.global_position) + (current_dir * GlobalConstants.TILES_SIZE)
		if owner.moveable_component.can_walk_towards(target_position):
			player.moveable_component.move(current_dir, target_position)
		else:
			if current_dir.x*current_dir.y != 0: #diagonal collision
				var projections : Array[Vector2i] = [Vector2i(current_dir.x, 0), Vector2i(0, current_dir.y)]
				var need_to_collide : bool = true
				
				for new_dir in projections:
					target_position = Vector2i(player.global_position) + (new_dir * GlobalConstants.TILES_SIZE)
					player.raycast.target_position = new_dir * GlobalConstants.TILES_SIZE
					player.raycast.force_raycast_update()
					
					if owner.moveable_component.can_walk_towards(target_position):
						player.moveable_component.turn(new_dir)
						state_machine.transition_to("PlayerStateWalk", {"dir" : new_dir})
						need_to_collide = false
						break
					
					if need_to_collide:
						state_machine.transition_to("PlayerStateColliding", {"dir" : current_dir})
			else:
				state_machine.transition_to("PlayerStateColliding", {"dir" : current_dir})


func enter(_message : Dictionary = {}) -> void:
	super()
	current_dir = _message["dir"]
	next_dir = current_dir


func after_walk() -> void:
	if next_dir == Vector2i.ZERO:
		state_machine.transition_to("PlayerStateIdle")
	elif next_dir != current_dir:
		player.moveable_component.turn(next_dir)
		state_machine.transition_to("PlayerStateWalk", {"dir" : next_dir})
