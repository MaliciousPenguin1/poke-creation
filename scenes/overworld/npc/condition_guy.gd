extends Entity


var i : int = 0

func hello(_message : Dictionary = {}) -> void:
	i = 1
	print("Hello")


func world(_message : Dictionary = {}) -> void:
	i = 0
	print("World")


func cond(_message : Dictionary = {}) -> bool:
	return i == 0
