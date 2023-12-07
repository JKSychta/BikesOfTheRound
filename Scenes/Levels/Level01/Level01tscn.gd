extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	game_start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	getPause()
	pass

func game_start():
	Global.resetScore()
	postionThePlayer()
	$Delivery_System/delivery_spawn.spawn_package_pick_up()
	$GameCountdownTimer.resetToDefault()
	$GameCountdownTimer.start()
	
	
func game_over():
#	$Enemy_Spawner.killAll()
	spawnerKill()
	$Player.holding_delivery = false
	$Delivery_System.deselect_all()
	

func _on_game_countdown_timer_timeout():
	game_over()
	game_start()

func postionThePlayer():
	$Player.position = $PlayerSpawn.position
	$Player.rotation = deg_to_rad(270)
	$Player.holding_delivery = false
	$Player.set_player_health()


func _on_player_player_dead():
	game_over()
	
func spawnerKill():
	get_tree().call_group("EnemySpawners", "killAll")
#	for i in len(spawners):
#		spawners[i].killAll()
func getPause():
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused:
			get_tree().paused = false
		else:
			get_tree().paused = true
			
		
