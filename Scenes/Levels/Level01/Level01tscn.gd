extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.save_score()
	game_start()

func game_start():
	Global.reset_score()
	position_the_player()
	$Delivery_System/DeliverySpawn.spawn_package_pick_up()
	$GameCountdownTimer.resetToDefault()
	$GameCountdownTimer.start()
	$LevelMusic.play()
	get_tree().call_group("EnemySpawners", "spawn")
	
func game_over():
	$Player/CanvasLayer/UserInterface.game_over()
	spawner_kill()
	$Player.holding_delivery = false
	$Player.velocity = Vector2.ZERO
	$Delivery_System.deselect_all()
	Global.update_score()

func _on_game_countdown_timer_timeout():
	game_over()

	
func position_the_player():
	$Player.position = $PlayerSpawn.position
	$Player.rotation = deg_to_rad(270)
	$Player.holding_delivery = false
	$Player.set_player_health()

func _on_player_player_dead():
	game_over()

	
func spawner_kill():
	get_tree().call_group("EnemySpawners", "kill_all")
	
func _on_user_interface_retry():
	game_start()

