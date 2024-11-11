extends VBoxContainer


var buttons : Array[Node] = []
var valid_buttons : Array[Node] = []
var valid_need_to_call : Array[Callable] = []
var conditions : Array[Callable] = [always_true, always_true, always_true, always_true, always_true, always_true, always_true]
var need_to_call : Array[Callable] = [call_grimoire, call_party, call_bag, call_profile, call_save, call_parameters, call_return]
var max_index = 0
var current_index = 0


#
# Overriding superclass functions
#


func _ready() -> void:
	await sort_children
	await sort_children
	
	buttons = get_children()
	for child in buttons:
		child.button_down.connect(_on_clicked_button)

	var need_to_sort = on_entering_ui()
	
	if need_to_sort:
		await sort_children

	set_index(0, true)


func _input(_event: InputEvent) -> void:
	if _event is InputEventKey:
		get_viewport().set_input_as_handled()
		if Input.is_action_just_pressed("move_down"):
			set_index(current_index + 1, true)
		elif Input.is_action_just_pressed("move_up"):
			set_index(current_index - 1, true)
		elif Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("run"):
			call_return()
		elif Input.is_action_just_pressed("interact"):
			_on_clicked_button()
	elif _event is InputEventMouseMotion:
		for button in valid_buttons:
			if button.is_hovered():
				button.grab_focus()



#
# Signal related functions
#


func _on_clicked_button() -> void:
	valid_need_to_call[current_index].call()
	
	
#
# Callables on each button click
#


func call_grimoire() -> void:
	pass
	

func call_party() -> void:
	pass
	
	
func call_bag() -> void:
	pass
	
	
func call_profile() -> void:
	pass
	
	
func call_save() -> void:
	pass
	
	
func call_parameters() -> void:
	pass
	
	
func call_return() -> void:
	ScenesManager.start_clock()
	owner.queue_free()


#
# Callables for conditions
#


func always_true() -> bool:
	return true

func always_false() -> bool:
	return false

#
# Others
#


func on_entering_ui() -> bool:
	var need_to_sort : bool = false
	max_index = 0

	var need_to_show_child : bool = false
	for idx in len(buttons):
		need_to_show_child = conditions[idx].call()
		
		buttons[idx].visible = need_to_show_child
		buttons[idx].index = max_index
		max_index += int(need_to_show_child)
		need_to_sort = need_to_sort or !need_to_show_child
		
		if need_to_show_child:
			valid_need_to_call.append(need_to_call[idx])
		
	valid_buttons = buttons.filter(func(button) : return button.visible)
	
	return need_to_sort


func set_index(idx : int, need_to_update_focus = false) -> void:
	current_index = idx % max_index
	if need_to_update_focus:
		valid_buttons[current_index].grab_focus()
