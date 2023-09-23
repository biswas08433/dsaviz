extends Node2D
@onready var label = $Label

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
	tween_born_01.tween_property(self, "scale", Vector2(1,1), .5) \
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)
	await tween_born_01.finished

func die():
	var tween_die_01 = create_tween()
	tween_die_01.tween_property(self, "scale", Vector2(0,0), 0.5) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	await tween_die_01.finished
