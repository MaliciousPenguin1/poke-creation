extends Node


##An autoload to add and remove 2D and UI scenes to the main one. 


enum SceneType {WORLD, UI, ENTITY}


@onready var main : Main = get_tree().root.get_child(-1)


##Adds a scene to the main one.
func add_scene(scene_path : String, scene_type : SceneType, coordinates : Vector2i = Vector2i.ZERO) -> void:
	var final_position : Vector2i = coordinates * GlobalConstants.TILES_SIZE
	
	match scene_type:
		SceneType.WORLD:
			var scene : Node2D = load(scene_path).instantiate()
			scene.global_position = final_position
			main.world_parent.add_child(scene)
		SceneType.ENTITY:
			var scene : Node2D = load(scene_path).instantiate()
			final_position.x += GlobalConstants.TILES_SIZE / 2
			final_position.y += GlobalConstants.TILES_SIZE / 2
			scene.global_position = final_position
			main.world_parent.add_child(scene)
		SceneType.UI:
			var scene : Control = load(scene_path).instantiate()
			scene.global_position = coordinates
			main.ui_parent.add_child(scene)


##Removes a scene from the main one. Providing a scene type isn't necessary but it is recommended.
func remove_scene(scene_name : String, scene_type : SceneType) -> void:
	match scene_type:
		SceneType.WORLD:
			var node_to_remove : Node2D = get_node(str(main.world_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
			GlobalVar.reserved_tiles.clear()
		SceneType.ENTITY:
			var node_to_remove : Node2D = get_node(str(main.world_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
		SceneType.UI:
			var node_to_remove : Control = get_node(str(main.ui_parent.get_path()) + "/" + scene_name)
			if node_to_remove:
				node_to_remove.queue_free()
		_:
			var node_to_remove := main.find_child(scene_name)
			if node_to_remove:
				node_to_remove.queue_free()


##Show the pause menu
func show_pause_menu() -> void:
	if not GlobalVar.can_pause:
		return
	
	stop_clock()
	get_tree().paused = true
	add_scene("res://scenes/ui/pause_menu/pause_menu.tscn", SceneType.UI)


#Stops the internal time
func stop_clock() -> void:
	for child in main.world_parent.get_children():
		if child is GameTime:
			child.stop_clock()


#Starts the internal time
func start_clock() -> void:
	for child in main.world_parent.get_children():
		if child is GameTime:
			child.start_clock()
