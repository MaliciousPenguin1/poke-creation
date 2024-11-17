extends Node


var DATA : Dictionary = {
	1: ["res://scenes/overworld/worlds/maps/maplink_test/mapA.tscn", 
	[[2, Vector2i(0, -48)], [3, Vector2i(0, -48)]]
	],
	2: ["res://scenes/overworld/worlds/maps/maplink_test/mapB.tscn", 
	[[1, Vector2i(0, 48)], [3, Vector2i(0, 0)]]
	],
	3: ["res://scenes/overworld/worlds/maps/maplink_test/mapC.tscn", 
	[[1, Vector2i(0, 48)], [2, Vector2i(0, 0)], [4, Vector2i(144, 0)]]
	],
	4: ["res://scenes/overworld/worlds/maps/maplink_test/mapD.tscn", 
	[[3, Vector2i(-144, 0)]]
	]
}


var LOADED_MAP_IDS : Array[int] = []


func get_neighbours_data(id : int) -> Array:
	return DATA[id][1]


func get_neighbours_ids(id : int) -> Array:
	return get_neighbours_data(id).reduce(func(accum, data):  accum.append(data[0]); return accum, [])


func is_already_loaded(id : int) -> bool:
	return id in LOADED_MAP_IDS


func get_scene_resource_name(id : int) -> String:
	return DATA[id][0]


func register_loaded(id : int) -> void:
	LOADED_MAP_IDS.append(id)


func register_unloaded(id : int) -> void:
	LOADED_MAP_IDS.erase(id)


func get_currently_loaded_map_ids() -> Array[int]:
	return LOADED_MAP_IDS
