extends Control


@onready var buttons_container: VBoxContainer = %VBoxContainer
@onready var choose_audio: AudioStreamPlayer = %ChooseAudio
@onready var select_audio: AudioStreamPlayer = %SelectAudio


@export var starting_map_id : int
@export var starting_pos : Vector2i


var buttons : Array[Node] = []
var max_index : int
var current_index : int = 0
var can_process_keyboard : bool = true
var play_sound : bool = false

func _ready() -> void:
	buttons = buttons_container.get_children()
	
	for idx in len(buttons):
		buttons[idx].index = idx
		buttons[idx].need_to_change_index.connect(set_index)
		buttons[idx].button_down.connect(interact_with_current_button)


	max_index = len(buttons)
	buttons[0].grab_focus()
	play_sound = true


func _input(_event: InputEvent) -> void:
	if _event is InputEventKey:
		get_viewport().set_input_as_handled()
		if can_process_keyboard:
			if Input.is_action_pressed("move_down"):
				set_index(current_index + 1)
			elif Input.is_action_pressed("move_up"):
				set_index(current_index - 1)
			elif Input.is_action_just_pressed("pause"):
				select_audio.play()
				while select_audio.is_playing():
					pass
				queue_free()
			elif Input.is_action_just_pressed("interact"):
				interact_with_current_button()
	elif _event is InputEventMouseMotion:
		for button in buttons:
			if button.is_hovered():
				button.grab_focus()


func set_index(index : int) -> void:
	current_index = index % max_index
	buttons[current_index].grab_focus()
	
	if play_sound:
		choose_audio.play()
		can_process_keyboard = false
		get_tree().create_timer(GlobalConstants.UI_KEYBOARD_COOLDOWN).timeout.connect(func(): can_process_keyboard = true)


func interact_with_current_button() -> void:
	select_audio.play()
	while select_audio.is_playing():
		pass
	
	var current_button : MainMenuButton = buttons[current_index]
	if current_button.is_new_game():
		ScenesManager.add_scene("res://scenes/overworld/player/Player.tscn", ScenesManager.SceneType.ENTITY, starting_pos)
		ScenesManager.add_map_scene(starting_map_id)
		
		for child in ScenesManager.main.world_parent.get_children():
			if child is Player:
				ScenesManager.main.custom_camera.reparent(child)
				ScenesManager.main.custom_camera.move_to_parent()
				break
		queue_free()
	elif current_button.is_option():
		pass
	else:
		pass
