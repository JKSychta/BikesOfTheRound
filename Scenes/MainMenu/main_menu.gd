extends Control

#var hiScores : Dictionary 
# Called when the node enters the scene tree for the first time.
func _ready(): 
	$VBoxContainer/StartButton.grab_focus()
	set_Scores()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


func _on_start_button_pressed():
#	get_tree().change_scene_to_file("res://Scenes/Levels/Test Level/TestLevel.tscn")
	get_tree().change_scene_to_file("res://Scenes/Levels/Level01/Level01tscn.tscn")
	


func _on_quit_button_pressed():
	get_tree().quit()

func set_Scores():
	var scoreString: String
	for i in len(Global.loadedScores["scores"]):
		scoreString += str(i+1,". ", Global.loadedScores["scores"][i], "\n")
	$HiScores.text = str("Hiscores\n", scoreString)

