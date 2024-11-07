extends State
class_name NpcState


const DIRECTIONS : Dictionary = {
	Vector2i(-1,0) : "Left",
	Vector2i(-1,-1) : "UpLeft",
	Vector2i(-1,1) : "DownLeft",
	Vector2i(1,0) : "Right",
	Vector2i(1,-1) : "UpRight",
	Vector2i(1,1) : "DownRight",
	Vector2i(0,-1) : "Up",
	Vector2i(0,1) : "Down"
}


@export var animation_name : String


var callback


func _ready() -> void:
	await owner.ready
	owner.current_state = self


func enter(_message : Dictionary = {}) -> void:
	if animation_name:
		owner.sprite.play(animation_name + DIRECTIONS[owner.moveable_component.facing_direction])
		owner.raycast.target_position = owner.moveable_component.facing_direction * GlobalConstants.TILES_SIZE
