extends Node
class_name TextParser


var PARSE_TABLE : Dictionary = {
	"{PLAYER_NAME}" : replace_player_name,
	"{E}" : add_e_for_female,
	"{MONEY}" : replace_money,
}


func _ready() -> void:
	GlobalVar.text_parser = self


func translate_and_parse_text(text : String) -> String:
	text = tr(text)

	for token in PARSE_TABLE.keys():
		text = PARSE_TABLE[token].call(text, token)

	return text


func replace_player_name(input : String, token : String) -> String:
	return input.replace(token, GlobalVar.player.player_name)


func add_e_for_female(input : String, token : String) -> String:
	var target_string : String
	match GlobalVar.player.gender:
		GlobalConstants.PlayerGender.MALE:
			target_string = ""
		GlobalConstants.PlayerGender.FEMALE:
			target_string = "e"
	
	return input.replace(token, target_string)


func replace_money(input : String, token : String) -> String:
	return input.replace(token, str(GlobalVar.player.money))
