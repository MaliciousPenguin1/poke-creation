extends MarginContainer
class_name MainMenuButton


signal need_to_change_index(new_index : int)
signal button_down


enum Type {NEW_GAME, OPTION, CONTINUE}
const NON_SELECTED_OPACITY_PERCENTAGE : float = 0.5


@export var type : int


@onready var label: Label = %Label
@onready var button: Button = %Button


var selected : bool = false
var index : int


func _ready() -> void:
	modulate.a = NON_SELECTED_OPACITY_PERCENTAGE
	
	match type:
		Type.NEW_GAME:
			label.text = tr("NEW_GAME")
		Type.OPTION:
			label.text = tr("OPTION")
			
	
	button.button_down.connect(_on_button_down)


func select() -> void:
	selected = true
	modulate.a = 1.0
	need_to_change_index.emit(index)


func unselect() -> void:
	selected = false
	modulate.a = NON_SELECTED_OPACITY_PERCENTAGE


func _on_mouse_entered() -> void:
	grab_focus()


func _on_focus_entered() -> void:
	if !selected:
		select()


func _on_focus_exited() -> void:
	if selected:
		unselect()


func is_new_game() -> bool:
	return type == Type.NEW_GAME


func is_option() -> bool:
	return type == Type.OPTION
	

func is_continue() -> bool:
	return type == Type.CONTINUE


func is_hovered() -> bool:
	return button.is_hovered()


func _on_button_down() -> void:
	button_down.emit()
