extends Node

#func _ready():
#	randomize()

var score = 0

func increaseScore(points):
	score+= points
	
func resetScore():
	score = 0
