extends Control


@onready var world_parent: Node2D = $"../../../WorldParent"
@onready var custom_camera: CustomCamera = $"../../../WorldParent/CustomCamera"
@onready var buttons_container: VBoxContainer = %VBoxContainer


@export var starting_map_scene_name : String
@export var starting_pos : Vector2i


var buttons : Array[Node] = []
var max_index : int
var current_index : int = 0


func _ready() -> void:
	buttons = buttons_container.get_children()
	
	for idx in len(buttons):
		buttons[idx].index = idx
		buttons[idx].need_to_change_index.connect(set_index)
	
	
	max_index = len(buttons)
	buttons[0].grab_focus()


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("move_down"):
		set_index(current_index + 1)
	elif Input.is_action_pressed("move_up"):
		set_index(current_index - 1)
	elif Input.is_action_pressed("interact"):
		interact_with_current_button()


func set_index(index : int) -> void:
	current_index = index % max_index
	buttons[current_index].grab_focus()


func interact_with_current_button() -> void:
	var current_button : MainMenuButton = buttons[current_index]
	if current_button.is_new_game():
		ScenesManager.add_scene("res://scenes/overworld/player/Player.tscn", ScenesManager.SceneType.ENTITY, starting_pos)
		ScenesManager.add_scene(starting_map_scene_name, ScenesManager.SceneType.WORLD)
		
		for child in world_parent.get_children():
			if child is Player:
				custom_camera.reparent(child)
				custom_camera.move_to_parent()
				break
		queue_free()
	elif current_button.is_option():
		pass
	else:
		pass
