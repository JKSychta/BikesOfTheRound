extends Control

var target = Vector2.ZERO
var currentTarget: Vector2
var playerPosition: Vector2
@onready var navigationArrow = $NavigationArrow
@onready var timeLeft = $TimeLeft
var playerHealth
var paused := false
var gameOver := false
signal retry
# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOverOverlay.hide()
	$PauseMenuOverlay.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	navigationArrow.rotation = playerPosition.angle_to_point(currentTarget) + deg_to_rad(90)
	if !gameOver:
		get_input()
	

func _on_player_player_global_position(player_global_position):
	playerPosition = player_global_position
	pass
	

func _on_delivery_spawn_navigation_target_spawn(target):
	currentTarget = target 
	$NavigationArrow.self_modulate = Color.RED



func _on_delivery_system_navigation_target(target):
	currentTarget = target  # Replace with function body.
	$NavigationArrow.self_modulate = Color.GREEN



func _on_player_health_changed(health):
	$LivesText.lives = health


	
func get_input():
	if Input.is_action_just_pressed("escape"):
		if !paused:
			get_tree().paused = true
			paused = true
			$PauseMenuOverlay.show()
			$PauseMenuOverlay/VBoxContainer/ContinueButton.grab_focus()
		else:
			get_tree().paused = false
			paused = false

			$PauseMenuOverlay.hide()
			


func _on_continue_button_pressed():
	get_tree().paused = false
	paused = false
	$PauseMenuOverlay.hide()
			


func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")


func _on_retry_button_pressed():
	emit_signal("retry")
	$GameOverOverlay.hide()
	gameOver = false
	get_tree().paused = false
	
func game_over():
	gameOver = true
	get_tree().paused = true
	$GameOverOverlay.show()
	$GameOverOverlay/VBoxContainer/RetryButton.grab_focus()

	
	
