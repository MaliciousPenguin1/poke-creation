extends Node
class_name Settings

##The path to the default settings file.
const DEFAULT_SETTINGS_DIRECTORY : String = "res://settings.cfg"
##The path to the user's settings file.
const USER_SETTINGS_DIRECTORY : String = "user://settings.cfg"

##List of the actions found in Project->Project Settings...->Input Map.
const ACTIONS_LIST : Array[String] = ["interact", "cancel", "pause", "move_up", "move_down", "move_left", "move_right", "run"]
##The maximum amount of decibels by which the volume of the game can be amplified. 
const VOLUME_MAX : int = 32
##Codes of all of the locales of the languages available in your game based on the list of available locales 
##found [url=https://docs.godotengine.org/en/stable/tutorials/i18n/locales.html#doc-locales]here[/url].
const VALID_LANGUAGES : Array[String] = ["en", "es", "fr"]
##The default language that should be used by your game.
const DEFAULT_LANGUAGE : String = "en"

##The various text speed available.
enum TextSpeed{SLOW,NORMAL,FAST,INSTANT}


#region Variables meant to be accessed by other scripts.
static var text_speed : int
#endregion

static var config_file : ConfigFile  = ConfigFile.new()

##Set all of the settings.
static func set_settings() -> void:
	check_config_file()
	_set_general_settings()
	_set_graphics_settings()
	_set_audio_settings()
	_set_controls_settings()
	_set_phone_settings()

##Check if the user already has a config file and create a default one when they don't.
static func check_config_file() -> void:
	if not FileAccess.file_exists(USER_SETTINGS_DIRECTORY):
		DirAccess.copy_absolute(DEFAULT_SETTINGS_DIRECTORY,USER_SETTINGS_DIRECTORY)
		language_setup()
	
	var error = config_file.load(USER_SETTINGS_DIRECTORY)

	if error != OK:
		push_error("There was a problem with the settings.cfg file.")
		return

##Takes a settings based on its setting_name in the settings.cfg file and gives it a new_value.
static func change_setting(setting_name : String, new_value : Variant) -> void:
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

##Sets the game's current language.
static func language_setup() -> void:
	var error = config_file.load(USER_SETTINGS_DIRECTORY)

	if error != OK:
		push_error("There was a problem with the settings.cfg file.")
		return
	
	var language : String = OS.get_locale_language()
	if language not in VALID_LANGUAGES:
		language = DEFAULT_LANGUAGE
	
	config_file.set_value("General", "language", language)
	config_file.save(USER_SETTINGS_DIRECTORY)
	TranslationServer.set_locale(language)


static func _set_general_settings() -> void:
	text_speed = config_file.get_value("General", "text_speed")


static func _set_graphics_settings() -> void:
	DisplayServer.window_set_size(config_file.get_value("Graphics", "resolution"))
	if config_file.get_value("Graphics", "fullscreen") == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

static func _set_audio_settings() -> void:
	_set_bus_audio(0, config_file.get_value("Audio", "master"))
	_set_bus_audio(1, config_file.get_value("Audio", "music"))
	_set_bus_audio(2, config_file.get_value("Audio", "sounds"))
	_set_bus_audio(3, config_file.get_value("Audio", "pokemon_cries"))

##Set the value of the audio level for the a bus defined by its bus_id.
static func _set_bus_audio(bus_id : int, value : int) -> void:
	var volume : int = roundi(((value / 100.0 * VOLUME_MAX * 2) - VOLUME_MAX))
	
	if volume == -VOLUME_MAX:
		AudioServer.set_bus_mute(bus_id, true)
	else:
		AudioServer.set_bus_mute(bus_id, false)
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

##Manages how the movement are implemented when the player uses a joypad.
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
