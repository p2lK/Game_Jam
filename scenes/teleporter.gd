extends Sprite2D

@export var target_position: Vector2

func _on_area_2d_body_entered(body):
	if body.name == 'player':
		body.position = target_position
