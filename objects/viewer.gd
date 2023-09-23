extends Node2D

@export var max_speed = 100

var velocity_target: Vector2
var velocity: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity_target = input_direction * max_speed
	velocity = lerp(velocity, velocity_target, 0.3)
	position += velocity

func reset():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2.ZERO, 0.7) \
		.set_trans(Tween.TRANS_EXPO) \
		.set_ease(Tween.EASE_OUT)
