extends HBoxContainer
class_name HBoxOptionsContainer


##A container that allows you to scroll between multiple options from a list.


@onready var button_left: TextureSoundButton = $ButtonLeft
@onready var options_label: Control = $OptionsLabel
@onready var button_right: TextureSoundButton = $ButtonRight


#Once Godot 4.4 is release, use @export var values : Dictionary[String, Variant] where the key 
#is what should be displayed in the label
##The values the user can choose from, where each entry has a string as its key that corresponds to the 
##text that should be displayed and any kind of type as its value.
@export var values : Dictionary
##An array used to define in which order the different values should be presented since dictionaries 
##are unordered. Each members of the array correspond to one of the keys in the values dictionary.
@export var keys_array : Array[String]
##If set to true, going past the last key from keys_array will send you back to the first one and 
##scrolling before the first key will send you to the last one.
@export var infinite_scroll : bool = true

##The option currently displayed by this node.
var current_option_index : int = 0 :
	set(value):
		current_option_index = value
		_on_current_option_index_changed()

##Wether this node is the one being focused.
var selected : bool = false :
	set(value):
		selected = value
		_on_selected()


func _ready() -> void:
	_set_buttons_state()
	Observer.deselect_other_options.connect(_on_deselect_other_options)

##Handles wether the arrows on the sides should be disabled based on the current_option_index when 
##infinite_scroll is set to false.
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

##Handles what happens when one of the user press the right or left keys to choose the next/previous option.
func _input(event: InputEvent) -> void:
	if not selected or event is InputEventMouseMotion:
		return
	
	if (event.is_action_pressed("ui_left") or event.is_action_pressed("move_left")) and not button_left.disabled:
		_on_button_left_pressed()
	
	if (event.is_action_pressed("ui_right") or event.is_action_pressed("move_right")) and not button_right.disabled:
		_on_button_right_pressed()

##A virtual function meant to be used by the childs of this class.
func _on_current_option_index_changed() -> void:
	pass

##Handles what happens when the user press the left key or click on the left arrow.
func _on_button_left_pressed() -> void:
	if current_option_index - 1 < 0:
		current_option_index = values.size() - 1
	else:
		current_option_index -= 1
	
	options_label.text = keys_array[current_option_index]
	_set_buttons_state()

##Handles what happens when the user press the right key or click on the right arrow.
func _on_button_right_pressed() -> void:
	if current_option_index + 1 == values.size():
		current_option_index = 0
	else:
		current_option_index += 1
	
	options_label.text = keys_array[current_option_index]
	_set_buttons_state()

##A virtual function meant to be used by the childs of this class.
func _on_selected() -> void:
	pass


func _on_focus_entered() -> void:
	selected = true
	Observer.deselect_other_options.emit(self)


func _on_mouse_entered() -> void:
	selected = true
	Observer.deselect_other_options.emit(self)

##Set the selected variable to false if this node isn't the one who sent the deselect_other_options 
##signal from the Observer autoload.
func _on_deselect_other_options(node : Control) -> void:
	if node == self:
		return
	
	selected = false
