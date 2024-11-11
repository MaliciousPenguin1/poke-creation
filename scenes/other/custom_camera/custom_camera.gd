extends Camera2D
class_name CustomCamera


func _ready() -> void:
	zoom = Vector2(GlobalConstants.CAMERA_ZOOM, GlobalConstants.CAMERA_ZOOM)
	

func move_to_parent(duration : float = 0.0) -> void:
		var tween : Tween = create_tween()
		tween.tween_property(self, "global_position", get_parent().global_position, duration)
