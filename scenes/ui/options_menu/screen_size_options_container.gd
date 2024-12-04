extends SettingsHBoxOptionsContainer
class_name ScreenSizeOptionsContainer


var values_to_use : Array


func _ready() -> void:
	super()
	values_to_use = values
	_hide_unused_values()
	_set_last_value()


func _set_current_option() -> void:
	super()
	values_to_use = values
	_hide_unused_values()
	_set_last_value()
	if current_option_index == values_to_use.size() - 1:
		Settings.config_file.set_value("Graphics", "fullscreen", true)
		Settings.change_setting(cfg_key, values_to_use[-1])
	else:
		Settings.config_file.set_value("Graphics", "fullscreen", false)
		Settings.change_setting(cfg_key, values_to_use[current_option_index])
	
	if current_option_index == 0: #It sucks to do it that way but I don't know why it doesn't work the normal way. -Sulucnal
		DisplayServer.window_set_size(values_to_use[0])


func _hide_unused_values() -> void:
	var screen_size : Vector2i = DisplayServer.screen_get_size()
	for value in values_to_use:
		if value > screen_size:
			values_to_use.remove_at(values_to_use.size() - 2)
			options_list.get_child(-2).queue_free()


func _set_last_value() -> void:
	values_to_use[-1] = values_to_use[-2]
