extends TextureRect


@onready var label: Label = %Label
@onready var icons: Array[TextureRect] = [%Icon_Printemps, %Icon_Ete, %Icon_Automne, %Icon_Hiver]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = GameTime.get_formatted_current_date()
	
	var current_month : int = GameTime.month
	icons[current_month].visible = true
