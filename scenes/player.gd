extends CharacterBody2D

@onready var sprite = $midas_lennox
@onready var bg = get_parent().find_child('backgrounds')

var speed = 200.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir = Vector2(0, 0)
	
	dir.x = Input.get_action_strength('right') - Input.get_action_strength('left')
	dir.y = Input.get_action_strength('down') - Input.get_action_strength('up')
	
	if dir.x < 0:
		sprite.scale.x = -1
	elif dir.x > 0:
		sprite.scale.x = 1
	
	if dir == Vector2(0, 0):
		sprite.play('idle')
	else:
		sprite.play('walk')
	
	dir = dir.normalized()
	
	velocity = dir * speed
	
	move_and_slide()
