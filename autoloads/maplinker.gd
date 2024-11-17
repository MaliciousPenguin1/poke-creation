extends Node


var DATA : Dictionary = {
	1: ["res://scenes/overworld/worlds/maps/maplink_test/mapA.tscn", 
	[[2, Vector2i(0, -1)], [3, Vector2i(0, -1)]]
	],
	2: ["res://scenes/overworld/worlds/maps/maplink_test/mapB.tscn", 
	[[1, Vector2i(0, 1)], [3, Vector2i(0, 0)]]
	],
	3: ["res://scenes/overworld/worlds/maps/maplink_test/mapC.tscn", 
	[[1, Vector2i(0, 1)], [2, Vector2i(0, 0)], [4, Vector2i(3, 0)], [5, Vector2i(0, 3)]]
	],
	4: ["res://scenes/overworld/worlds/maps/maplink_test/mapD.tscn", 
	[[3, Vector2i(-3, 0)], [5, Vector2i(-3, 3)]]
	],
	5: ["res://scenes/overworld/worlds/maps/maplink_test/mapE.tscn", 
	[[3, Vector2i(0, -3)], [4, Vector2i(3, -3)]]
	]
}
var LOADED_MAP_IDS : Array[int] = []
var LOADED_CHUNKS : Dictionary = {
}

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


func register_chunk(chunk : Chunk) -> void:
	if !chunk in LOADED_CHUNKS.keys():
		LOADED_CHUNKS[chunk] = [chunk.global_position, {}]
		

func unregister_chunk(chunk : Chunk) -> void:
	LOADED_CHUNKS.erase(chunk)


func register_entity_in_chunk(chunk : Chunk, entity : Entity) -> void:
	remove_entity_from_chunk(entity)
	entity.current_chunk = chunk

	LOADED_CHUNKS[chunk][1][entity] = null


func remove_entity_from_chunk(entity : Entity) -> void:
	if entity.current_chunk in LOADED_CHUNKS.keys():
		LOADED_CHUNKS[entity.current_chunk][1].erase(entity)


func refresh_chunks(chunk : Chunk) -> void:
	var pos_diff : Vector2
	var rendering_distance : int = GlobalConstants.CHUNK_RENDREING_DISTANCE*GlobalConstants.CHUNK_SIZE*GlobalConstants.TILES_SIZE 
	for loaded_chunk in LOADED_CHUNKS:
		pos_diff = abs(chunk.global_position - loaded_chunk.global_position)
		if loaded_chunk == chunk or pos_diff.x <= rendering_distance and pos_diff.y <= rendering_distance:
			activate_chunk(loaded_chunk)
		else:
			deactivate_chunk(loaded_chunk)


func activate_chunk(chunk : Chunk) -> void:
	chunk.need_to_process = true
	for entity in LOADED_CHUNKS[chunk][1].keys():
		print("REACTIVATING ENTITY ", entity)
		entity.set_process_mode(0) 


func deactivate_chunk(chunk : Chunk) -> void:
	chunk.need_to_process = false
	for entity in LOADED_CHUNKS[chunk][1].keys():
		print("STOPPING ENTITY ", entity)
		entity.set_process_mode(4) 
