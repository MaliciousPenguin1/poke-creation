extends Control
class_name Menu_Button

var ICON_SIZE : Vector2i = Vector2i(23, 22)
var OFFSET_WHEN_SELECTED : int = -8
var X_OFFSET_ATLAS_TEXTURE : int = 23


@export var icon : AtlasTexture
@export var label_text : String


@onready var icon_texture_rect: TextureRect = %Icon
@onready var label: Label = %Label


var index : int
var real_index: int


func _ready() -> void:
	icon_texture_rect.texture = icon
	label.text = label_text


func _on_mouse_entered() -> void:
	position.x += OFFSET_WHEN_SELECTED
	icon_texture_rect.texture.region.position.x = X_OFFSET_ATLAS_TEXTURE
	get_parent().set_index(index)


func _on_mouse_exited() -> void:
	position.x -= OFFSET_WHEN_SELECTED
	icon_texture_rect.texture.region.position.x = 0
