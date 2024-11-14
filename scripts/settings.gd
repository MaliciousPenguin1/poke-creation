extends Node
class_name Settings


const ACTIONS_LIST : Array[String] = ["interact", "cancel", "pause", "move_up", "move_down", "move_left", "move_right", "run"]


enum TextSpeed{SLOW,NORMAL,FAST,INSTANT}


static var autosave : bool = false
static var text_speed : int

static var config_file : ConfigFile  = ConfigFile.new()


static func set_settings() -> void:
	_check_config_file()
	_set_general_settings()
	_set_graphics_settings()
	_set_audio_settings()
	_set_controls_settings()
	_set_phone_settings()


static func _check_config_file() -> void:
	if not FileAccess.file_exists("user://settings.cfg"):
		DirAccess.copy_absolute("res://settings.cfg","user://settings.cfg")
	
	var error = config_file.load("user://settings.cfg")

	if error != OK:
		push_error("There was a problem with the settings.cfg file.")
		return


func change_setting(setting_name : String, new_value : Variant) -> void:
	for section in config_file.get_sections():
		if setting_name in config_file.get_section_keys(section):
			config_file.set_value(section, setting_name, new_value)
			match section:
				"General":
					_set_general_settings()
				"Graphics":
					_set_graphics_settings()
				"Audio":
					_set_audio_settings()
				"Controls":
					_set_controls_settings()
				"Phone":
					_set_phone_settings()
			return
	
	push_error("Couldn't find a setting called \"" + setting_name +"\".")


static func _set_general_settings() -> void: #SaveManager pas encore implémenté.
	autosave = config_file.get_value("General", "autosave")
	text_speed = config_file.get_value("General", "text_speed")


static func _set_graphics_settings() -> void:
	DisplayServer.window_set_size(config_file.get_value("Graphics", "resolution"))
	if config_file.get_value("Graphics", "fullscreen") == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


static func _set_audio_settings() -> void:
	_set_bus_audio(0, config_file.get_value("Audio", "master"))
	_set_bus_audio(1, config_file.get_value("Audio", "music"))
	_set_bus_audio(2, config_file.get_value("Audio", "sounds"))


static func _set_bus_audio(bus_id : int, value : int) -> void:
	var volume : int = roundi((value / 100.0 * 80) - 8)
	AudioServer.set_bus_volume_db(bus_id, volume)


static func _set_controls_settings() -> void:
	for action in ACTIONS_LIST:
		InputMap.action_erase_events(action)
		if config_file.has_section_key("Controls", "keyboard_" + action):
			var input_event : InputEventKey = InputEventKey.new()
			input_event.keycode = config_file.get_value("Controls", "keyboard_" + action)
			InputMap.action_add_event(action, input_event)
		if config_file.has_section_key("Controls", "joypad_" + action):
			var input_event : InputEventJoypadButton = InputEventJoypadButton.new()
			input_event.button_index = config_file.get_value("Controls", "joypad_" + action)
			InputMap.action_add_event(action, input_event)
	
	_set_joypad_movement()


static func _set_joypad_movement() -> void: #TODO: Make it shorter by using a loop and Dictionaries/Arrays.
	var move_forward_input : InputEventJoypadMotion = InputEventJoypadMotion.new()
	move_forward_input.axis = JOY_AXIS_LEFT_Y
	move_forward_input.axis_value = -1
	InputMap.action_add_event("move_up", move_forward_input)
	
	var move_backward_input : InputEventJoypadMotion = InputEventJoypadMotion.new()
	move_backward_input.axis = JOY_AXIS_LEFT_Y
	move_backward_input.axis_value = 1
	InputMap.action_add_event("move_down", move_backward_input)
	
	var move_left_input : InputEventJoypadMotion = InputEventJoypadMotion.new()
	move_left_input.axis = JOY_AXIS_LEFT_X
	move_left_input.axis_value = -1
	InputMap.action_add_event("move_left", move_left_input)
	
	var move_right_input : InputEventJoypadMotion = InputEventJoypadMotion.new()
	move_right_input.axis = JOY_AXIS_LEFT_X
	move_right_input.axis_value = 1
	InputMap.action_add_event("move_right", move_right_input)


static func _set_phone_settings() -> void:
	pass
