extends CanvasLayer
class_name CustomCanvasLayer


func _ready() -> void:
	print(offset)
	scale = Vector2(GlobalConstants.CAMERA_ZOOM, GlobalConstants.CAMERA_ZOOM)
	print(offset)
