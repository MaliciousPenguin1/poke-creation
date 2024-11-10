extends VBoxContainer


var buttons : Array[Node] = []
var valid_buttons : Array[Node] = []
var conditions : Array[Callable] = [always_true, always_true, always_true]
var need_to_call : Array[Callable] = [always_true, always_true, always_true]
var max_index = 0
var current_index = 0


func _ready() -> void:
	self.visible = false
	
	buttons = get_children()
	for child in buttons:
		child.button_down.connect(_on_clicked_button)

	on_entering_ui()


func on_entering_ui() -> void:
	max_index = 0

	var need_to_show_child : bool
	for idx in len(buttons):
		need_to_show_child = conditions[idx].call()
		
		buttons[idx].visible = need_to_show_child
		buttons[idx].index = max_index
		max_index += int(need_to_show_child)
		
		buttons[idx].real_index = idx
		
	valid_buttons = buttons.filter(func(button) : return button.visible)


func always_true() -> bool:
	return true


func _on_clicked_button() -> void:
	need_to_call[current_index].call()
	

func set_index(idx) -> void:
	current_index = idx % max_index
	

func _unhandled_input(_event: InputEvent) -> void:
	if visible:
		pass
