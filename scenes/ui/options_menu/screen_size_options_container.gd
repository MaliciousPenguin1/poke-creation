extends SettingsHBoxOptionsContainer
class_name ScreenSizeOptionsContainer


func _ready() -> void:
	super()
	_hide_unused_values()
	_set_last_value()


func _set_current_option() -> void:
	super()
	if current_option_index == values.size() - 1:
		Settings.config_file.set_value("Graphics", "fullscreen", true)
		Settings.change_setting(cfg_key, values[-1])
	else:
		Settings.config_file.set_value("Graphics", "fullscreen", false)
		Settings.change_setting(cfg_key, values[current_option_index])
	
	if current_option_index == 0: #It sucks to do it that way but I don't know why it doesn't work the normal way. -Sulucnal
		DisplayServer.window_set_size(values[0])


func _hide_unused_values() -> void:
	var screen_size : Vector2i = DisplayServer.screen_get_size()
	for value in values:
		if value > screen_size:
			values.remove_at(values.size() - 2)
			options_list.get_child(-2).queue_free()


func _set_last_value() -> void:
	values[-1] = values[-2]
