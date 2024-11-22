extends Node


var LINEAGES : Dictionary
var POKEMON_DATA : Dictionary

func _ready() -> void:
	var file : FileAccess
	var json_as_string : String
	
	file = FileAccess.open("res://data/lineages.json", FileAccess.ModeFlags.READ)
	json_as_string = file.get_as_text()
	LINEAGES = JSON.parse_string(json_as_string)
	file.close()
	
	file = FileAccess.open("res://data/pokedex.json", FileAccess.ModeFlags.READ)
	json_as_string = file.get_as_text()
	POKEMON_DATA = JSON.parse_string(json_as_string)
	file.close()
