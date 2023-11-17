extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
<<<<<<< Updated upstream
	pass # Replace with function body.
	#game_start()
=======
	game_start()
	pass

>>>>>>> Stashed changes



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_start():
	Global.resetScore()
	$Player.position = $PlayerSpawn.position
	$GameCountdownTimer.start()
	
func game_over():
	$Enemy_Spawner.killAll()
	$Player.holding_delivery = false
	

func _on_game_countdown_timer_timeout():
	game_over()
	game_start()

