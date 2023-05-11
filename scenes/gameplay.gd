extends Node2D

@onready var player = $player

var time = -1
var time_to_transition = .5

var player_target_pos

var last_alpha
var goal_alpha

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

func _on_teleporter_3_teleport_player_to(target_position):
	set_player_position(target_position)

func _on_teleporter_2_teleport_player_to(target_position):
	set_player_position(target_position)

func _on_teleporter_teleport_player_to(target_position):
	set_player_position(target_position)
