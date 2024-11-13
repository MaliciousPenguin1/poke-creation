extends Node


##Temporaire, juste pour faire des tests.


@onready var world_parent: Node2D = $"../WorldParent"
@onready var custom_camera: CustomCamera = $"../WorldParent/CustomCamera"


func _ready() -> void:
	await owner.ready
	ScenesManager.add_scene("res://scenes/ui/main_menu/main_menu.tscn", ScenesManager.SceneType.UI)
	queue_free()
