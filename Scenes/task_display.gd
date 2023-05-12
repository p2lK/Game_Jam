extends Node2D

@onready var label = $Label

var time_to_transition = 1.0
var time = -1

var last_pos: Vector2
var goal_pos: Vector2

func _ready():
	unhide_this()

func _process(delta):
	if time >= 0:
		var t = time / time_to_transition
		
		change_position(ease_in_and_out(t))
		
		time += delta
		
		if time >= time_to_transition:
			position = goal_pos
			time = -1

func hide_this():
	set_new_position(Vector2(0, 160))

func unhide_this():
	change_text()
	set_new_position(Vector2(0, 0))

func set_new_position(new_pos):
	last_pos = position
	goal_pos = new_pos
	time = 0

func change_position(t: float):
	position = (1-t) * last_pos + t * goal_pos

func ease_in_and_out(x: float) -> float:
	x = (sin(PI * (x - .5)) + 1) / 2
	return x

func ease_in(x: float) -> float:
	x = sin((PI / 2) * (x - 1)) + 1
	return x

func ease_out(x: float) -> float:
	x = sin((PI / 2) * x)
	return x

func change_text():
	var text = ''
	
	var parent = get_parent()
	
	if parent.talked_to_patient and parent.collected_apple:
		text = 'Du hast alle Aufgaben für den ersten Tag erledigt, in der finalen Version würdest du jetzt zum zweiten Tag kommen. \nVielen Dank fürs Spielen!!! \nCredits: Writing: Linda \nArt: Emily, Yasemin, Nina\nCoding: Kai, Emily, Laurin'
	else:
		text += 'Erledige diese Aufgaben:\n'
		
		if !parent.talked_to_patient:
			text += '- Rede mit deinen Patienten\n'
		
		if !parent.collected_apple:
			text += '- Sammel in der Cafeteria einen Apfel ein\n'
			text += '- Bring Mr. MacClellan einen Apfel\n'
		
		text += '- Vervollständige dein Protokol in diesem Raum\n\n'
		
		text += 'Tutorial: WASD zum Bewegen und E/Space zum interagieren.'
		
	label.text = text
		
