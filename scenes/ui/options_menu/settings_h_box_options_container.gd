extends HBoxOptionsContainer
class_name SettingsHBoxOptionsContainer


@export var cfg_section : String
@export var cfg_key : String
@export var values : Array

@export var section_name : String
@export var section_description: String


func _ready() -> void:
	if not owner is OptionsSubMenu:
		push_error("The owner of this button isn't an option sub menu.")
		return
	
	Settings.check_config_file()
	var current_value : Variant = Settings.config_file.get_value(cfg_section, cfg_key)
	var current_value_index : int = values.find(current_value)
	current_option = options_list.get_child(current_value_index)
	current_option.show()


func _set_current_option() -> void:
	if current_option_index >= values.size():
		push_error("The option selected isn't part of the values available.")
		return
	
	super()
	Settings.config_file.set_value(cfg_section, cfg_key, values[current_option_index])
	Settings.change_setting(cfg_key, values[current_option_index])


func _on_selected() -> void:
	var menu : OptionsSubMenu = owner as OptionsSubMenu
	menu.section_name_label.text = section_name
	menu.section_description_label.text = section_description
