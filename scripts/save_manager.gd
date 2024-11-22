extends Node
class_name SaveManager


#You can replace this value with anything you want.
const ENCRYPTION_PASS : String = "fC_2Dn{R9yP8Q@qm"


static var save_directory : String = OS.get_user_data_dir() + "/saves/"


static func save_data() -> void:
	var save_dict : Dictionary
	_save_player_data(save_dict)
	
	var save_path : String = save_directory + "save_" + str(GlobalVar.current_save_slot) + ".json"
	var save_file : FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, ENCRYPTION_PASS)
	var save_string = JSON.stringify(save_dict)


static func _save_player_data(save_dict : Dictionary) -> void:
	if not GlobalVar.player:
		push_error("Couldn't find a player assigned in GlobalVar.")
		return
	
	save_dict["player_name"] = GlobalVar.player.player_name
	save_dict["gender"] = GlobalVar.player.gender
	save_dict["trainer_id"] = GlobalVar.player.trainer_id
	save_dict["money"] = GlobalVar.player.money
	save_dict["player_position_x"] = GlobalVar.player.global_position.x
	save_dict["player_position_y"] = GlobalVar.player.global_position.y
	save_dict["animation"] = GlobalVar.player.sprite.animation


static func load_data() -> void:
	var load_path : String = save_directory + "save_" + str(GlobalVar.current_save_slot) + ".json"
	var save_file : FileAccess = FileAccess.open_encrypted_with_pass(load_path, FileAccess.READ, ENCRYPTION_PASS)
	var json : JSON = JSON.new()
	json.parse(save_file.get_as_text())
	var data_dict : Dictionary = json.data
	
	_load_player_data(data_dict)


static func _load_player_data(data_dict : Dictionary) -> void:
	await GlobalVar.player.ready
	GlobalVar.player.player_name = data_dict["player_name"]
	GlobalVar.player.gender = data_dict["gender"]
	GlobalVar.player.set_sprite()
	GlobalVar.player.sprite.animation = data_dict["animation"]
	GlobalVar.player.trainer_id = data_dict["trainer_id"]
	GlobalVar.player.money = int(data_dict["money"])
	GlobalVar.player.global_position.x = data_dict["player_position_x"]
	GlobalVar.player.global_position.y = data_dict["player_position_y"]
