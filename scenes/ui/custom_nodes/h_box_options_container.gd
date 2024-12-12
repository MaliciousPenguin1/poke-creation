extends HBoxContainer
class_name HBoxOptionsContainer


@onready var button_left: TextureSoundButton = $ButtonLeft
@onready var options_label: Control = $OptionsLabel
@onready var button_right: TextureSoundButton = $ButtonRight


#Once Godot 4.4 is release, use @export var values : Dictionary[String, Variant] where the key 
#is what should be displayed in the label
@export var values : Dictionary
@export var keys_array : Array[String]
@export var infinite_scroll : bool = true


var current_option : Node :
	set(value):
		current_option = value
		_set_current_option()

var last_option : Node
var current_option_index : int = 0 :
	set(value):
		current_option_index = value
		_on_current_option_index_changed()
var selected : bool = false :
	set(value):
		selected = value
		_on_selected()


func _set_current_option() -> void:
	_set_buttons_state()
	current_option_index = current_option.get_index()
func _ready() -> void:
	_set_buttons_state()
	Observer.deselect_other_options.connect(_on_deselect_other_options)


func _set_buttons_state() -> void:
	if infinite_scroll:
		return
	
	if current_option_index == 0:
		button_left.disabled = true
	else:
		button_left.disabled = false
	
	if current_option_index == values.size() - 1:
		button_right.disabled = true
	else:
		button_right.disabled = false


func _input(event: InputEvent) -> void:
	if not selected or event is InputEventMouseMotion:
		return
	
	if (event.is_action_pressed("ui_left") or event.is_action_pressed("move_left")) and not button_left.disabled:
		_on_button_left_pressed()
	
	if (event.is_action_pressed("ui_right") or event.is_action_pressed("move_right")) and not button_right.disabled:
		_on_button_right_pressed()


func _on_current_option_index_changed() -> void:
	pass


func _on_button_left_pressed() -> void:
	if current_option_index - 1 < 0:
		current_option_index = values.size() - 1
	else:
		current_option_index -= 1
	
	options_label.text = keys_array[current_option_index]
	_set_buttons_state()


func _on_button_right_pressed() -> void:
	if current_option_index + 1 == values.size():
		current_option_index = 0
	else:
		current_option_index += 1
	
	options_label.text = keys_array[current_option_index]
	_set_buttons_state()


func _on_selected() -> void:
	pass


func _on_focus_entered() -> void:
	selected = true
	Observer.deselect_other_options.emit(self)


func _on_mouse_entered() -> void:
	selected = true
	Observer.deselect_other_options.emit(self)


func _on_deselect_other_options(node : Control) -> void:
	if node == self:
		return
	
	selected = false
