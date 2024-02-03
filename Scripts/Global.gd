extends Node

var score: int = 0
var loaded_scores: Dictionary
var score_save_location: String = "user://scores.save"


func _ready():
	loaded_scores = load_score()

func increase_score(points: int):
	score+= points
	
func reset_score():
	score = 0


func save_score():
	var score_to_save = loaded_scores
	var score_file = FileAccess.open(score_save_location, FileAccess.WRITE)
	var json_string = JSON.stringify(score_to_save)
	score_file.store_line(json_string)

func load_score() -> Dictionary:
	if not FileAccess.file_exists(score_save_location):
		loaded_scores = {"scores":[1000,500,100]}
		save_score()
	var score_file = FileAccess.open(score_save_location, FileAccess.READ)
	var json_string = score_file.get_as_text()
	var score_dictionary = JSON.parse_string(json_string)
	return score_dictionary

func update_score():
	loaded_scores["scores"].sort()
	loaded_scores["scores"].reverse()
	if !(loaded_scores["scores"].has(score)):
		if loaded_scores["scores"].min() < score:
			loaded_scores["scores"][len(loaded_scores["scores"])-1] = score
			loaded_scores["scores"].sort()
			loaded_scores["scores"].reverse()
			print("score updated")
			save_score()
			loaded_scores = load_score()
