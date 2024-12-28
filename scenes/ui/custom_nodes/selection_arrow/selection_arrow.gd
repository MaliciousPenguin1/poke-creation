extends TextureRect
class_name SelectionArrow


##The arrow that shows which option is selected in a list of buttons.
##To use it, attach an instance of this node to your menu root and assign the menu containing 
##the various buttons that can be choosen from to the "buttons_list" parameter.


##The speed at which the arrow goes back and forth.
const ANIM_SPEED : float = 0.5
##The amount of pixels by which the arrow is offseted during every other frame of animation.
const ANIM_OFFSET : Vector2 = Vector2(2,0)


##The parent of all of the buttons that can be choosen.
@export var buttons_list : Control
##The value by which your arrow has to be offseted compared to the buttons it will be facing.
@export var buttons_offset : Vector2 = Vector2(0,0)


func _ready() -> void:
	_assign_signals()
	_animate()


func _assign_signals() -> void:
	for child in buttons_list.get_children():
		child as Control
		child.focus_entered.connect(_on_button_focus_entered.bind(child))


func _animate() -> void:
	var tween : Tween = create_tween().set_loops()
	tween.tween_property(self, "position", position + ANIM_OFFSET, 0).set_delay(ANIM_SPEED).from_current()
	tween.tween_property(self, "position", position - ANIM_OFFSET, 0).set_delay(ANIM_SPEED).from_current()


func _on_button_focus_entered(button : Control) -> void:
	position = button.global_position + buttons_offset
	position.y -= size.y / 2
	position.y += button.size.y / 2
