extends CharacterBody2D

@onready var sprite = $midas_lennox
@onready var bg = get_parent().find_child('backgrounds')
@onready var task_display = $task_display

@export var speed = 200.0

var can_move = true

var task_display_active = true

func lock():
	can_move = false
	sprite.play('idle')

func unlock():
	can_move = true

func _physics_process(delta):
	if task_display_active:
		if Input.is_action_just_released("interact"):
			task_display.hide_this()
			task_display_active = false
	elif can_move:
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

func _on_player_detector_interacted_with():
	if !task_display_active:
		if task_display.time == -1:
			task_display.unhide_this()
			task_display_active = true
