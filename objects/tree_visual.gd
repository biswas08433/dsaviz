extends Node2D

var tree_original: BinarySearchTree = BinarySearchTree.new()
var tree_node_visual = preload("res://objects/tree_node_visual.tscn")

var node_map = {}
var node_list = []

func _ready():
	randomize()
	for i in range(10):
		tree_original.insert(randi_range(0, 100))
	node_list = tree_original.inorder()
	print(node_list)
	create_tree_visual()

func create_tree_visual():
	for node in node_list:
		var tree_node_visual_instance = tree_node_visual.instantiate()
		node_map[node] = tree_node_visual_instance
		add_child(tree_node_visual_instance)
		tree_node_visual_instance.value = node.value
		tree_node_visual_instance.position = node.position
		await tree_node_visual_instance.born()

