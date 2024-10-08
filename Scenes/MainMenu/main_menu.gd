extends Control
## This is the script controling the main menu scene
 
# Called when the node enters the scene tree for the first time.
func _ready(): 
	$VBoxContainer/StartButton.grab_focus()
	set_Scores()


## On reciving a signal from the StartButton starts the game by loading the Level01 scene
func _on_start_button_pressed():
#	get_tree().change_scene_to_file("res://Scenes/Levels/Test Level/TestLevel.tscn")
	get_tree().change_scene_to_file("res://Scenes/Levels/Level01/Level01tscn.tscn")
	

## On reciving a signal from the QuitButton it exits the program
func _on_quit_button_pressed():
	get_tree().quit()

## set_Scores loads scores from the score JSON file. It then parsers the data into an array and places the values into HiScores label.
func set_Scores():
	var scoreString: String
	for i in len(Global.loadedScores["scores"]):
		scoreString += str(i+1,". ", Global.loadedScores["scores"][i], "\n")
	$HiScores.text = str("Hiscores\n", scoreString)

