extends SettingsHBoxOptionsContainer
class_name ScreenSizeOptionsContainer


const FULLSCREEN_KEY : String = "FULLSCREEN"


var values_to_use : Dictionary


func _ready() -> void:
	super()
	values_to_use = values
	_hide_unused_values()
	_set_last_value()


func _on_current_option_index_changed() -> void:
	super()
	values_to_use = values
	_hide_unused_values()
	_set_last_value()
	if current_option_index == values_to_use.size() - 1:
		Settings.config_file.set_value("Graphics", "fullscreen", true)
		Settings.change_setting(cfg_key, values[keys_array[-1]])
		
		await get_tree().process_frame #It sucks to do it that way but I don't know why it doesn't work the normal way. -Sulucnal
		options_label.text = FULLSCREEN_KEY
	else:
		Settings.config_file.set_value("Graphics", "fullscreen", false)
		Settings.change_setting(cfg_key, values[keys_array[current_option_index]])
	
	if current_option_index == values_to_use.size() - 2: #It sucks to do it that way but I don't know why it doesn't work the normal way. -Sulucnal
		DisplayServer.window_set_size(values[keys_array[-2]])


func _hide_unused_values() -> void:
	var screen_size : Vector2i = DisplayServer.screen_get_size()
	for value in values.values():
		if value > screen_size:
			values_to_use.erase(values_to_use.find_key(value))


func _set_last_value() -> void:
	values_to_use[FULLSCREEN_KEY] = values_to_use[values_to_use.find_key(values_to_use.values()[-2])]
