extends Node

#{
#	"scores": [90, 40, 2]
#}

#func _ready():
#	randomize()

var score = 0

func increaseScore(points):
	score+= points
	
func resetScore():
	score = 0


func save_score():
	var saveScore = {
		"scores": [100, 50, 10]
	}
	var scoreFile = FileAccess.open("res://Save/scores.json", FileAccess.WRITE)
	var jsonString = JSON.stringify(saveScore)
	scoreFile.store_line(jsonString)

func load_score() -> Dictionary:
	var scoreFile = FileAccess.open("res://Save/scores.json", FileAccess.READ)
	var jsonString = scoreFile.get_as_text()
	var scoreDictionary = JSON.parse_string(jsonString)
	return scoreDictionary
