extends Node2D

@export var max_speed = 100
@export var max_zoom = 5.0
@export var min_zoom = 0.1

@onready var camera_2d = $Camera2D

var velocity_target: Vector2
var zoom_target: float = 1.0
var zoom_factor = 0.05
var velocity: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity_target = input_direction * max_speed
	velocity = lerp(velocity, velocity_target, 0.3)
	camera_2d.zoom = lerp(camera_2d.zoom, Vector2(zoom_target, zoom_target), 0.3)
	position += velocity * (1/zoom_target)

func reset():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2.ZERO, 0.7) \
		.set_trans(Tween.TRANS_EXPO) \
		.set_ease(Tween.EASE_OUT)

func _unhandled_input(event: InputEvent):
	match event.get_class():
		"InputEventMouseButton":
			#print(event.button_index)
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					#print("z+1")
					zoom_target += zoom_factor
					zoom_target = clampf(zoom_target, min_zoom, max_zoom)
				MOUSE_BUTTON_WHEEL_DOWN:
					#print("z-1")
					zoom_target -= zoom_factor
					zoom_target = clampf(zoom_target, min_zoom, max_zoom)
