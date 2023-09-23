extends Node

var loading_screen = preload("res://scenes/loading_screen_canvas_layer.tscn")
var pause_screen = preload("res://scenes/pause_screen_canvas_layer.tscn")



enum {START, READY, PLAYING, PAUSED, END}
var game_state: int
var state_before_pause: int
var pause_scene_instance: Node

func _ready() -> void:
	pause_scene_instance = pause_screen.instantiate()
	get_tree().root.add_child.call_deferred(pause_scene_instance)

func change_scene(path, delay = 0.1):
	await get_tree().create_timer(delay).timeout
	var load_instance = loading_screen.instantiate()
	get_tree().root.add_child(load_instance)
	await load_instance.cover()
	get_tree().change_scene_to_file(path)
	await get_tree().node_added
	await load_instance.uncover()
	load_instance.queue_free()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if game_state == PLAYING or game_state == READY:
			state_before_pause = game_state
			game_state = PAUSED
			pause_scene_instance.process_mode = Node.PROCESS_MODE_INHERIT
			get_tree().set_group("level", "process_mode", Node.PROCESS_MODE_DISABLED)
			await pause_scene_instance.cover()
		elif game_state == PAUSED:
			await pause_scene_instance.uncover()
			pause_scene_instance.process_mode = Node.PROCESS_MODE_INHERIT
			get_tree().set_group("level", "process_mode", Node.PROCESS_MODE_INHERIT)
			game_state = state_before_pause

func restart():
	get_tree().call_group("level", "restart")
