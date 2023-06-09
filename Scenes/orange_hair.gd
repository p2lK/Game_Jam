extends Node2D

@onready var player_detector = $player_detector
@onready var label = $label
@onready var player = $"../../player"

func _process(delta):
	label.visible = player_detector.player_in_this

func _on_player_detector_interacted_with():
	if !player.collected_apple:
		label.text = 'Immer dieses unfähige Personal... wie oft muss ich mich noch vorstellen. Mr. MacClellan, bitteschön!'
	else:
		label.text = 'Danke für gar nichts! Ich hasse Äpfel, ich wollte eine Birne!!'

func _on_player_detector_player_exited():
	label.text = 'E zum interagieren'
