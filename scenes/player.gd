extends CharacterBody2D

@onready var sprite = $midas_lennox
@onready var bg = get_parent().find_child('backgrounds')
@onready var task_display = $task_display
@onready var black_screen = $black_screen

@export var speed = 200.0

var can_move = true

var task_display_active = true

var time = -1
var time_to_transition = .5

var player_target_pos

var last_alpha
var goal_alpha

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

func _process(delta):
	if time >= 0:
		var t = time / time_to_transition
		
		change_alpha(t)
		
		time += delta
		
		if time > time_to_transition:
			time = -1
			
			black_screen.modulate[3] = goal_alpha
			
			if black_screen.modulate[3] == 1:
				position = player_target_pos
				unlock()
				set_new_alpha(0)
				time = 0
				print('test')

func set_new_alpha(new_alpha: float):
	last_alpha = black_screen.modulate[3]
	goal_alpha = new_alpha

func change_alpha(t: float):
	black_screen.modulate[3] = (1 - t) * last_alpha + t * goal_alpha

func set_player_position(new_pos: Vector2):
	lock()
	player_target_pos = new_pos
	time = 0
	set_new_alpha(1)

func _on_player_detector_interacted_with():
	if !task_display_active:
		if task_display.time == -1:
			task_display.unhide_this()
			task_display_active = true
