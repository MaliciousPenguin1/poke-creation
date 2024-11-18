extends Node


##Temporaire, juste pour faire des tests.


@onready var world_parent: Node2D = $"../WorldParent"
@onready var custom_camera: CustomCamera = $"../WorldParent/CustomCamera"


func _ready() -> void:
	await owner.ready
	#ScenesManager.add_scene("res://scenes/ui/main_menu/main_menu.tscn", ScenesManager.SceneType.UI)
	
	#ScenesManager.add_scene("res://scenes/overworld/worlds/maps/debug_town_map.tscn", ScenesManager.SceneType.WORLD)
	ScenesManager.add_scene("res://scenes/overworld/player/Player.tscn", ScenesManager.SceneType.ENTITY)
	ScenesManager.add_map(
		"res://scenes/overworld/worlds/maps/map_linker_test_maps/test_map_1.tscn",
		"res://resources/world_layout_data/world_layout_test.tres"
	)
	custom_camera.reparent(GlobalVar.player)
	custom_camera.move_to_parent()
	
	#await get_tree().create_timer(1).timeout
	#Utils.show_dialog("BUCKET_ALCHEMY")
	#queue_free()
