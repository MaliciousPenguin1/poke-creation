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

var selected : bool = false :
	set(value):
		selected = value
		_on_selected()


func _set_current_option() -> void:
	_set_buttons_state()
	current_option_index = current_option.get_index()


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


func _on_selected() -> void:
	pass


func _on_focus_entered() -> void:
	selected = true


func _on_mouse_entered() -> void:
	selected = true


func _input(event: InputEvent) -> void:
	if not selected or event is InputEventMouseMotion:
		return
	
	if event.is_action_pressed("ui_left") or event.is_action_pressed("move_left"):
		_on_button_left_pressed()
	
	if event.is_action_pressed("ui_right") or event.is_action_pressed("move_right"):
		_on_button_right_pressed()
