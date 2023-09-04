class_name Bst extends Node2D

class BinaryTreeNode:
	var index: int = 0
	var value: float = 0.0
	var position: Vector3 = Vector3(0, -1, 0)
	var scale: float = 1
	var left_child = null
	var right_child = null

	func _init(v: float) -> void:
		self.value = v
	func _to_string() -> String:
		return str(value, position)

var value: float = 0
var left
