extends Node2D

var time_to_transition = 1.0
var time = -1

var last_pos: Vector2
var goal_pos: Vector2

func _ready():
	unhide_this()

func _process(delta):
	if time >= 0:
		var t = time / time_to_transition
		
		change_position(ease_in_and_out(t))
		
		time += delta
		
		if time >= time_to_transition:
			position = goal_pos
			time = -1

func hide_this():
	set_new_position(Vector2(0, 160))

func unhide_this():
	set_new_position(Vector2(0, 0))

func set_new_position(new_pos):
	last_pos = position
	goal_pos = new_pos
	time = 0
	print(new_pos)

func change_position(t: float):
	position = (1-t) * last_pos + t * goal_pos

func ease_in_and_out(x: float) -> float:
	x = (sin(PI * (x - .5)) + 1) / 2
	return x

func ease_in(x: float) -> float:
	x = sin((PI / 2) * (x - 1)) + 1
	return x

func ease_out(x: float) -> float:
	x = sin((PI / 2) * x)
	return x
