extends RefCounted
class_name BinarySearchTree

var root_original: BinarySearchTreeNode = null

var horizontal_offset = 100
var vertical_offset = 100

func _init():
	pass

class BinarySearchTreeNode extends RefCounted:
	# Data
	var value: int = 0
	var position: Vector2 = Vector2.ZERO
	
	# Pointers
	var left_child: BinarySearchTreeNode = null
	var right_child: BinarySearchTreeNode = null
	var parent: BinarySearchTreeNode = null

	func _init(v) -> void:
		self.value = v
		self.position = Vector2.ZERO
		
	func _to_string() -> String:
		return str(value, position)

# Insert a new value into the binary tree
func insert(value):
	if root_original == null:
		root_original = BinarySearchTreeNode.new(value)
	else:
		_insert_node(root_original, value)

# Internal function to recursively insert a node
func _insert_node(root: BinarySearchTreeNode, value: float):
	if value < root.value:
		if root.left_child == null:
			var new_node = BinarySearchTreeNode.new(value)
			root.left_child = new_node
			new_node.parent = root
			# TODO: position code
			new_node.position.x = new_node.parent.position.x - horizontal_offset
			new_node.position.y = new_node.parent.position.y + vertical_offset
		else:
			_insert_node(root.left_child, value)
	else:
		if root.right_child == null:
			var new_node = BinarySearchTreeNode.new(value)
			root.right_child = new_node
			new_node.parent = root
			# TODO: position code
			
			new_node.position.x = new_node.parent.position.x + horizontal_offset
			new_node.position.y = new_node.parent.position.y + vertical_offset
		else:
			_insert_node(root.right_child, value)

# Traverse the binary tree in-order and return a list of values
func _get_nodes_inorder(root) -> Array[BinarySearchTreeNode]:
	var nodes: Array[BinarySearchTreeNode] = []
	if root.left_child != null:
		nodes += _get_nodes_inorder(root.left_child)
	nodes.append(root)
	if root.right_child != null:
		nodes += _get_nodes_inorder(root.right_child)
	return nodes

func inorder() -> Array[BinarySearchTreeNode]:
	var nodes: Array[BinarySearchTreeNode] = []
	if root_original != null:
		nodes = _get_nodes_inorder(root_original)
	return nodes
	
