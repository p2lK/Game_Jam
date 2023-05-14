extends Sprite2D

@onready var parent = get_parent()

signal interacted_with
signal player_entered
signal player_exited

var time = -1
var time_to_transition = .5

var player_in_this = false

func _process(delta):
	if player_in_this:
		if Input.is_action_just_released("interact"):
			emit_signal('interacted_with')

func _on_area_2d_body_entered(body):
	if body.name == 'player':
		player_in_this = true
		emit_signal('player_entered')

func _on_area_2d_body_exited(body):
	if body.name == 'player':
		player_in_this = false
		
		emit_signal('player_exited')
