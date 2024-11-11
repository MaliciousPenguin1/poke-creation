extends TextureRect


@onready var label: Label = %Label
@onready var icon: TextureRect = %Icon


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "TEST"
