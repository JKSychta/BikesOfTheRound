extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	game_start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_start():
	Global.resetScore()
	postionThePlayer()
	$Delivery_System/delivery_spawn.spawn_package_pick_up()
	$GameCountdownTimer.resetToDefault()
	$GameCountdownTimer.start()
	
	
func game_over():
	$Enemy_Spawner.killAll()
	$Player.holding_delivery = false
	$Delivery_System.deselect_all()
	

func _on_game_countdown_timer_timeout():
	game_over()
	game_start()

func postionThePlayer():
	$Player.position = $PlayerSpawn.position
	$Player.rotation = deg_to_rad(270)
	$Player.holding_delivery = false
