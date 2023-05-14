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

func set_player_position(new_pos: Vector2):
	player.set_player_position(new_pos)
