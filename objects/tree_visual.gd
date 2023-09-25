extends Node2D

var tree_original: BinarySearchTree = BinarySearchTree.new()
var tree_node_visual = preload("res://objects/tree_node_visual.tscn")

var node_map = {}
var node_list = []
var edge_list = []

func _ready():
	randomize()
	for i in range(50):
		tree_original.insert(randi_range(0, 1000))
		node_list = tree_original.inorder()
		#print(node_list)
	create_tree_visual()

func create_tree_visual():
	#print(node_list)
	for node in node_list:
		create_and_add_node_visual(node)

# only updates the positions and add if any new node
func update_tree_visual():
	node_list = tree_original.inorder()
	print(node_list)
	print(node_map)
	for node in node_list:
		# update position if already present, else create a new visual node
		var tree_node_visual_instance = node_map.get(node)
		if tree_node_visual_instance:
			tree_node_visual_instance.position = node.position
		else:
			create_and_add_node_visual(node)
	queue_redraw()

# hard reset
func full_update_tree_visual():
	node_list = tree_original.inorder()
	#prints(node_list, node_map)
	for node in node_map:
		var tree_node_visual_instance = node_map[node]
		tree_node_visual_instance.die()
	node_map.clear()
	for node in node_list:
		create_and_add_node_visual(node)
	queue_redraw()

func reset():
	#print(tree_original.inorder())
	tree_original.clear()
	#print(tree_original.inorder())
	full_update_tree_visual()
	
func insert(v: int):
	tree_original.insert(v)
	update_tree_visual()

func create_and_add_node_visual(node):
	var tree_node_visual_instance = tree_node_visual.instantiate()
	node_map[node] = tree_node_visual_instance
	add_child(tree_node_visual_instance)
	tree_node_visual_instance.value = node.value
	tree_node_visual_instance.position = node.position
	tree_node_visual_instance.scale_target = 3/(1+float(node.depth))
	#print(tree_node_visual_instance.scale)
	await tree_node_visual_instance.born()

func _draw():
	edge_list = tree_original.get_edges()
	for i in range(0, edge_list.size(), 2):
		draw_line(edge_list[i], edge_list[i+1], Color.WHITE, 5.0, true)

