extends Node
class_name Main


##The main scene where everything happens. Scenes can be added or removed from it 
##using the ScenesManager autoload.


@onready var world_parent: Node2D = %WorldParent
@onready var ui_parent: Control = %UIParent
@onready var custom_camera: CustomCamera = %CustomCamera


func _ready() -> void:
	Settings.set_settings()
