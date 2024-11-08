extends Camera2D
class_name CustomCamera


func move_to_parent(duration : float = 0.0) -> void:
		var tween : Tween = create_tween()
		tween.tween_property(self, "global_position", get_parent().global_position, duration)
