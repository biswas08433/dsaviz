extends Node2D
@onready var label = $Label

var scale_target

var value :
	set(v):
		label.text = str(v)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO
	#await get_tree().create_timer(1).timeout
	#await born()
	#await get_tree().create_timer(1).timeout
	#await die()

func born():
	var tween_born_01 = create_tween()
	tween_born_01.tween_property(self, "scale", Vector2(scale_target,scale_target), .5) \
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)
	await tween_born_01.finished

func die():
	var tween_die_01 = create_tween()
	tween_die_01.tween_property(self, "scale", Vector2(0,0), 0.5) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween_die_01.tween_callback(queue_free)
	await tween_die_01.finished
