extends Node
@onready var score_label: Label = $ScoreLabel

var score = 0

func add_point() -> void:
	score += 1
	score_label.text = "Coins: " + str(score)
