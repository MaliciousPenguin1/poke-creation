extends TextureButton
class_name Menu_Button

var ICON_SIZE : Vector2i = Vector2i(23, 22)
var OFFSET_WHEN_SELECTED : int = -8
var ICON_ROTATION_AMPLITUDE_DEGREE : float = 8
var ICON_ROTATION_PERIOD : float = 1


@export var icon : AtlasTexture
@export var label_text : String


@onready var icon_texture_rect: TextureRect = %Icon
@onready var label: Label = %Label


var index : int
var real_index: int
var selected : bool
var tween : Tween


func _ready() -> void:
	icon_texture_rect.texture = icon
	icon_texture_rect.set_pivot_offset(icon_texture_rect.size/2)
	label.text = TextParser.translate_and_parse_text(label_text)
	selected = false


func select() -> void:
	selected = true
	position.x += OFFSET_WHEN_SELECTED
	icon_texture_rect.texture.region.position.x = ICON_SIZE.x
	get_parent().set_index(index)
	start_icon_rotation()


func unselect() -> void:
	selected = false
	position.x -= OFFSET_WHEN_SELECTED
	icon_texture_rect.texture.region.position.x = 0
	reset_icon_roation()


func _on_mouse_entered() -> void:
	grab_focus()


func _on_focus_entered() -> void:
	if !selected:
		select()


func _on_focus_exited() -> void:
	if selected:
		unselect()


func start_icon_rotation() -> void:
	tween = create_tween()
	tween.tween_property(icon_texture_rect, "rotation_degrees", -ICON_ROTATION_AMPLITUDE_DEGREE, ICON_ROTATION_PERIOD/4)
	tween.tween_callback(start_clockwise_icon_rotation)


func start_clockwise_icon_rotation() -> void:
	tween = create_tween()
	tween.tween_property(icon_texture_rect, "rotation_degrees", ICON_ROTATION_AMPLITUDE_DEGREE, ICON_ROTATION_PERIOD/2)
	tween.tween_callback(start_counterclockwise_icon_rotation)
	
	
func start_counterclockwise_icon_rotation() -> void:
	tween = create_tween()
	tween.tween_property(icon_texture_rect, "rotation_degrees", -ICON_ROTATION_AMPLITUDE_DEGREE, ICON_ROTATION_PERIOD/2)
	tween.tween_callback(start_clockwise_icon_rotation)


func reset_icon_roation() -> void:
	tween.kill()
	icon_texture_rect.rotation_degrees = 0
