extends Sprite2D

@onready var parent = get_parent()

signal item_collected(item_name: String)

var time = -1
var time_to_transition = .5

var player_target_pos

var last_alpha
var goal_alpha

var die_on_finished = false

func _process(delta):
	if time >= 0:
		var t = time / time_to_transition
		
		change_alpha(t)
		
		time += delta
		
		if time > time_to_transition:
			time = -1
			
			parent.modulate[3] = goal_alpha
			
			if die_on_finished:
				parent.queue_free()


func set_new_alpha(new_alpha: float):
	last_alpha = parent.modulate[3]
	goal_alpha = new_alpha
	time = 0

func change_alpha(t: float):
	parent.modulate[3] = (1 - t) * last_alpha + t * goal_alpha

func _on_area_2d_body_entered(body):
	if body.name == 'player':
		emit_signal('item_collected', parent.name)
		set_new_alpha(0)
		die_on_finished = true
