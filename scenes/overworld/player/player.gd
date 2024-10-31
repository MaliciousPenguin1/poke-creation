extends StaticBody2D
class_name Player

var _facing_direction : Vector2i = Vector2i(0, 0)
var facing_direction : Vector2i = _facing_direction :
	get: return _facing_direction
	set(dir):
		_facing_direction = dir
