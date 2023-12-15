extends Node


var score = 0
var loadedScores: Dictionary

func _ready():
	loadedScores = load_score()

func increaseScore(points):
	score+= points
	
func resetScore():
	score = 0


func save_score():
	var saveScore = loadedScores
	var scoreFile = FileAccess.open("res://Save/scores.json", FileAccess.WRITE)
	var jsonString = JSON.stringify(saveScore)
	scoreFile.store_line(jsonString)

func load_score() -> Dictionary:
	var scoreFile = FileAccess.open("res://Save/scores.json", FileAccess.READ)
	var jsonString = scoreFile.get_as_text()
	var scoreDictionary = JSON.parse_string(jsonString)
	return scoreDictionary

func update_score():
	loadedScores["scores"].sort()
	loadedScores["scores"].reverse()
	if !(loadedScores["scores"].has(score)):
		if loadedScores["scores"].min() < score:
			loadedScores["scores"][len(loadedScores["scores"])-1] = score
			loadedScores["scores"].sort()
			loadedScores["scores"].reverse()
			print("score updated")
			save_score()
			loadedScores = load_score()
		
		
	
