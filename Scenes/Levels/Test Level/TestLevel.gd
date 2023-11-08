extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#game_start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_start():
	Global.score = 0
	$Node2D/Player.position = $PlayerSpawn.position
