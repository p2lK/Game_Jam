extends Node2D

@onready var player = $player
@onready var teleporters = $teleporters.get_children()

var time = -1
var time_to_transition = .5

var player_target_pos

var last_alpha
var goal_alpha

func _ready():
	for teleporter in teleporters:
		var my_callable = Callable(self, 'set_player_position')
		teleporter.connect('teleport_player_to', set_player_position)

func _process(delta):
	if time >= 0:
		var t = time / time_to_transition
		
		change_alpha(t)
		
		time += delta
		
		if time > time_to_transition:
			time = -1
			
			modulate[3] = goal_alpha
			
			if modulate[3] == 0:
				player.position = player_target_pos
				set_new_alpha(1)
				time = 0

func set_new_alpha(new_alpha: float):
	last_alpha = modulate[3]
	goal_alpha = new_alpha

func change_alpha(t: float):
	modulate[3] = (1 - t) * last_alpha + t * goal_alpha

func set_player_position(new_pos: Vector2):
	player_target_pos = new_pos
	time = 0
	set_new_alpha(0)
