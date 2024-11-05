extends Node


##An autoload to add and remove 2D and UI scenes to the main one. 


enum SceneType {SCENE_2D, SCENE_UI}


@onready var main : Main = get_tree().root.get_child(-1)


##Adds a scene to the main one.
func add_scene(scene_path : String, scene_type : SceneType) -> void:
	match scene_type:
		SceneType.SCENE_2D:
			var scene : Node2D = load(scene_path).instantiate()
			main.world_parent.add_child(scene)
		SceneType.SCENE_UI:
			var scene : Control = load(scene_path).instantiate()
			main.ui_parent.add_child(scene)


##Removes a scene from the main one. Providing a scene type isn't necessary but it is recommended.
func remove_scene(scene_name : String, scene_type : SceneType) -> void:
	match scene_type:
		SceneType.SCENE_2D:
			var node_to_remove : Node2D = main.world_parent.find_child(scene_name, false)
			node_to_remove.queue_free()
		SceneType.SCENE_UI:
			var node_to_remove : Node2D = main.world_parent.find_child(scene_name, false)
			node_to_remove.queue_free()
		_:
			var node_to_remove := main.find_child(scene_name)
			node_to_remove.queue_free()
