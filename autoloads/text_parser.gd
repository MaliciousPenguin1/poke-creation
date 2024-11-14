extends Node


var PARSE_TABLE : Dictionary = {
	"PLAYER_NAME" : replace_player_name,
	"E" : add_e_for_female,
	"MONEY" : replace_money,
}


func translate_and_parse_text(text : String, context_table : Dictionary = {}) -> String:
	text = tr(text)
	
	return text.format(evaluate(PARSE_TABLE, context_table))


func evaluate(input_table : Dictionary, context_table : Dictionary) -> Dictionary:
	var output_table : Dictionary = {}
	
	for token in input_table.keys():
		output_table[token] = input_table[token].call()

	return output_table.merged(context_table, true)
	

func replace_player_name() -> String:
	return GlobalVar.player.player_name


func add_e_for_female() -> String:
	return "" if GlobalVar.player.gender == GlobalConstants.PlayerGender.MALE else "e"


func replace_money() -> String:
	return str(GlobalVar.player.money)
