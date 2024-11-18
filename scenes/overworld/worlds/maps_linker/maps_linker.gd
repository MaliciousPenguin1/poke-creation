@tool
extends Node2D
class_name MapsLinker


#Quand on passera à Godot 4.4, utiliser la fonction ci-dessous @ la place:
#https://godotengine.org/article/dev-snapshot-godot-4-4-dev-3/#export_tool_button-annotation
@export var save_layout : bool = false :
	set(value) : 
		_on_save_button_clicked(value)
@export var load_layout : bool = false :
	set(value) : 
		_on_load_button_clicked(value)
@export var clear_layout : bool = false :
	set(value) : 
		_on_clear_button_clicked(value)


const SAVE_WINDOW : PackedScene = preload("res://scenes/overworld/worlds/maps_linker/save_window.tscn")
const LOAD_WINDOW : PackedScene = preload("res://scenes/overworld/worlds/maps_linker/load_window.tscn")


var data_to_save : Dictionary = {}


func _on_save_button_clicked(value : bool) -> void:
	if value == false:
		return
	
	#Format:
#{
#	map_1_scene_file_path : {
#		"map_name" : String,
#		"position_in_world" : Vector2i,
#		"neighbors" : Array[other_maps_resource_paths]
#		"neighbors_node_paths" : Array[NodePath]
#	},
#	map_2_scene_file_path : {
#		"map_name" : String,
#		"position_in_world" : Vector2i,
#		"neighbors" : Array[other_maps_resource_paths] <- Used in the world to handle the chunk logic.
#		"neighbors_node_paths" : Array[NodePath] <- Used in the map inker to set the export var "neighbors" of the map.
#	},
#	...
#},
#Utilise une resource de type "WorldLayoutData"
	data_to_save.clear()
	for child in get_children():
		if child is not Map:
			push_error("The node \"" + child.name + "\" isn't a map.")
			continue
		
		child = child as Map
		data_to_save[child.scene_file_path] = {
			"map_name" = child.name,
			"position_in_world" = child.global_position,
			"neighbors" = _get_neighbors(child),
			"neighbors_node_paths" = _get_neighbors(child)
		}
	
	var save_window : FileDialog = SAVE_WINDOW.instantiate()
	save_window.add_filter("*.tres", "World Layout file")
	save_window.file_selected.connect(_on_save_window_file_selected)
	save_window.popup_centered(save_window.min_size)
	get_tree().root.add_child(save_window)
	
	value == false


func _on_save_window_file_selected(path : String) -> void:
	var resource : WorldLayoutData = WorldLayoutData.new()
	resource.data = data_to_save
	ResourceSaver.save(resource, path)


func _get_neighbors(map : Map) -> PackedStringArray:
	var array : PackedStringArray
	for neighbor in map.neighbors:
		array.append(neighbor.scene_file_path)
	return array


func _get_neighbors_node_paths(map : Map) -> Array[NodePath]:
	var array : Array[NodePath]
	for neighbor in map.neighbors:
		array.append(neighbor.get_path())
	return array


func _on_load_button_clicked(value : bool) -> void:
	if value == false:
		return
	
	var load_window : FileDialog = LOAD_WINDOW.instantiate()
	load_window.add_filter("*.tres", "World Layout file")
	load_window.file_selected.connect(_on_load_window_file_selected)
	load_window.popup_centered(load_window.min_size)
	get_tree().root.add_child(load_window)
	
	value == false


func _on_load_window_file_selected(path : String) -> void:
	print("Please wait while the maps are being loaded...")
	var resource : WorldLayoutData = ResourceLoader.load(path)
	for key in resource.data.keys():
#region Potential threaded loading system if performances issues are noticed.
		#ResourceLoader.load_threaded_request(key)
		#while ResourceLoader.load_threaded_get_status(key) != ResourceLoader.THREAD_LOAD_LOADED:
			#await get_tree().process_frame
		#var map : PackedScene = ResourceLoader.load_threaded_get(key)
#endregion
		var map : PackedScene = load(key)
		var map_instance : Map = map.instantiate()
		map_instance.name = resource.data[key]["map_name"]
		map_instance.global_position = resource.data[key]["position_in_world"]
		add_child(map_instance)
	
	_define_neighbors(resource)


func _define_neighbors(resource : WorldLayoutData) -> void:
	var index : int = 0
	
	for entry in resource.data:
		var map : Map = get_child(index) as Map
		map.neighbors = (entry["neighbors_node_paths"])
		index += 1 
	
	print("World layout loaded successfully!")


func _on_clear_button_clicked(value : bool) -> void:
	if value == false:
		return
	
	for child in get_children():
		child.queue_free()
	
	value == false
