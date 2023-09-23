class_name BinarySearchTree
var root: BinarySearchTreeNode = null

func _init():
	pass

class BinarySearchTreeNode:
	var value: int = 0
	var position: Vector2 = Vector2.ZERO
	var depth: int = 0
	var left_child = null
	var right_child = null
	var parent = null

	func _init(v) -> void:
		self.value = v
	func _to_string() -> String:
		return str(value, position)

# Insert a new value into the binary tree
func insert(value):
	if root == null:
		root = BinarySearchTreeNode.new(value)
	else:
		_insert_node(root, value)

# Internal function to recursively insert a node
func _insert_node(node: BinarySearchTreeNode, value: float):
	if value < node.value:
		if node.left_child == null:
			node.left_child = BinarySearchTreeNode.new(value)
			node.left_child.parent = node
			# TODO: position code
		else:
			_insert_node(node.left_child, value)
	else:
		if node.right_child == null:
			node.right_child = BinarySearchTreeNode.new(value)
			node.right_child.parent = node
			# TODO: position code
		else:
			_insert_node(node.right_child, value)

# Traverse the binary tree in-order and return a list of values
func get_nodes_inorder(node):
	if node == null:
		return
	var nodes = []
	if node.left_child != null:
		nodes += get_nodes_inorder(node.left_child)
	nodes.append(node)
	if node.right_child != null:
		nodes += get_nodes_inorder(node.right_child)
	return nodes
