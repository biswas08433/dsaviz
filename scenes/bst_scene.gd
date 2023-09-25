extends Node2D

@onready var viewer = $Viewer
@onready var tree_visual = $TreeVisual




func _on_bst_scene_control_view_reset():
	#print("view reset")
	viewer.reset()


func _on_bst_scene_control_tree_reset():
	#print("tree reset")
	tree_visual.reset()


func _on_bst_scene_control_submitted(value, op):
	match op:
		"INSERT" :
			tree_visual.insert(int(value))
