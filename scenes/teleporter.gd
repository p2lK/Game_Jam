extends Sprite2D

@export var target_position: Vector2

signal teleport_player_to(target_position: Vector2)

func _on_area_2d_body_entered(body):
	if body.name == 'player':
		emit_signal('teleport_player_to', target_position)
		
		#body.position = target_position
