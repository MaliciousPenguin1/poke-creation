extends Resource
class_name WorldLayoutData


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
#		"neighbors" : Array[other_maps_resource_paths]
#		"neighbors_node_paths" : Array[NodePath]
#	},
#	...
#},
@export var data : Dictionary
