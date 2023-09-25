extends RefCounted
class_name BinarySearchTree

var root_original: BinarySearchTreeNode = null

var unit_distance: float = 128
var node_scaling_factor

var max_depth: int = 0

func _init():
	pass
class BinarySearchTreeNode extends RefCounted:
	# Data
	var index: int = 0
	var value: int = 0
	var position: Vector2 = Vector2.ZERO
	var depth = 0
	# Pointers
	var left_child: BinarySearchTreeNode = null
	var right_child: BinarySearchTreeNode = null
	var parent: BinarySearchTreeNode = null

	func _init(v) -> void:
		self.value = v
		self.position = Vector2.ZERO
		
	func _to_string() -> String:
		return str(value, position, depth)

# Insert a new value into the binary tree
func insert(value: int):
	if root_original == null:
		root_original = BinarySearchTreeNode.new(value)
	else:
		_insert_node(root_original, value, 0, 0)

# Internal function to recursively insert a node
# each nodes depth, and index is provided by this depth and index variable
func _insert_node(root: BinarySearchTreeNode, value: int, index: int, depth: int):
	if depth > max_depth:
		max_depth = depth
	if value < root.value:
		if root.left_child == null:
			# pointer adjustments
			var new_node = BinarySearchTreeNode.new(value)
			root.left_child = new_node
			new_node.parent = root
			
			# depth adjustment
			new_node.depth = depth+1
			# TODO: position code
			#new_node.position.x = new_node.parent.position.x - (horizontal_offset/ratio)
			#new_node.position.y = new_node.parent.position.y + vertical_offset
		else:
			
			#root.left_child.position.x = root.position.x - (horizontal_offset/ratio)			
			_insert_node(root.left_child, value, depth+1, 2*index+1)
	else:
		if root.right_child == null:
			var new_node = BinarySearchTreeNode.new(value)
			#pointer adjustments
			root.right_child = new_node
			new_node.parent = root
			# TODO: position code
			
			#new_node.position.x = new_node.parent.position.x + (horizontal_offset/ratio)
			#new_node.position.y = new_node.parent.position.y + vertical_offset
			new_node.depth = depth+1
		else:
			#root.right_child.position.x = root.position.x + (horizontal_offset/ratio)
			_insert_node(root.right_child, value, depth+1, 2*index+2)

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


func clear():
	_clear(root_original)
	root_original = null
	
func _clear(root: BinarySearchTreeNode):
	if root == null:
		return
	_clear(root.left_child)
	_clear(root.right_child)
	root.left_child = null
	root.right_child = null

func get_edges() -> Array[Vector2]:
	var edges: Array[Vector2] = []
	if root_original != null:
		edges = _get_edges(root_original)
	return edges
	
func _get_edges(root: BinarySearchTreeNode)->Array[Vector2]:
	var edges: Array[Vector2] = []
	if root.left_child != null:
		edges.append(root.position)
		edges.append(root.left_child.position)
		edges += _get_edges(root.left_child)
	if root.right_child != null:
		edges.append(root.position)
		edges.append(root.right_child.position)
		edges += _get_edges(root.right_child)
	return edges

# todo: main
func get_position(i, d, md)-> Vector2i:
	var out: Vector2i
	out.y = d
	out.x = (1 << md-d)
	var si = 1 << d
	
	return out
	
