extends HBoxContainer
class_name HBoxOptionsContainer


@onready var button_left: TextureSoundButton = $ButtonLeft
@onready var options_list: Control = $OptionsList
@onready var button_right: TextureSoundButton = $ButtonRight


@export var infinite_scroll : bool = true


var current_option : Node :
	set(value):
		current_option = value
		_set_current_option()
var last_option : Node
var current_option_index : int = 0


#Use the _ready() function to set the option it is meant to show.


func _set_current_option() -> void:
	_set_buttons_state()
	current_option_index = current_option.get_index()
	#Use an array of possible values and a statement like "screen_res = array[current_option_index]"
	pass


func _set_buttons_state() -> void:
	if infinite_scroll:
		return
	
	if current_option == options_list.get_child(0):
		button_left.disabled = true
	else:
		button_left.disabled = false
	
	if current_option == options_list.get_child(options_list.get_child_count() - 1):
		button_right.disabled = true
	else:
		button_right.disabled = false


func _on_button_left_pressed() -> void:
	current_option_index -= 1
	if current_option_index < 0:
		current_option_index = options_list.get_child_count() - 1
	
	last_option = current_option
	current_option = options_list.get_child(current_option_index)
	
	last_option.hide()
	current_option.show()


func _on_button_right_pressed() -> void:
	current_option_index += 1
	if current_option_index == options_list.get_child_count():
		current_option_index = 0
	
	last_option = current_option
	current_option = options_list.get_child(current_option_index)
	
	last_option.hide()
	current_option.show()
