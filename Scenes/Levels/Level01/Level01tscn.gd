extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.save_score()
	game_start()
	pass

func game_start():
	Global.reset_score()
	position_the_player()
	$Delivery_System/delivery_spawn.spawn_package_pick_up()
	$GameCountdownTimer.resetToDefault()
	$GameCountdownTimer.start()
	$LevelMusic.play()
	
	
func game_over():
	spawner_kill()
	$Player.holding_delivery = false
	$Player.velocity = Vector2.ZERO
	$Delivery_System.deselect_all()
	Global.update_score()

func _on_game_countdown_timer_timeout():
	game_over()
	$Player/CanvasLayer/User_Interface.game_over()
	

func position_the_player():
	$Player.position = $PlayerSpawn.position
	$Player.rotation = deg_to_rad(270)
	$Player.holding_delivery = false
	$Player.set_player_health()


func _on_player_player_dead():
	game_over()
	$Player/CanvasLayer/User_Interface.game_over()
	
	
func spawner_kill():
	get_tree().call_group("EnemySpawners", "kill_all")
	
	
func get_pause():
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused:
			get_tree().paused = false
		else:
			get_tree().paused = true



func _on_user_interface_retry():
	game_start()
