extends Node

var score = 0
var loadedScores: Dictionary
var scoreSaveLocation: String = "user://scores.save"


func _ready():
	loadedScores = load_score()

func increaseScore(points):
	score+= points
	
func resetScore():
	score = 0

func create_save():
	var saveScore = {"scores":[1000,500,100]}
	var scoreFile = FileAccess.open(scoreSaveLocation, FileAccess.WRITE)
	var jsonString = JSON.stringify(saveScore)
	scoreFile.store_line(jsonString)

func save_score():
	var saveScore = loadedScores
	var scoreFile = FileAccess.open(scoreSaveLocation, FileAccess.WRITE)
	var jsonString = JSON.stringify(saveScore)
	scoreFile.store_line(jsonString)

func load_score() -> Dictionary:
	if not FileAccess.file_exists(scoreSaveLocation):
		create_save()
	var scoreFile = FileAccess.open(scoreSaveLocation, FileAccess.READ)
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
