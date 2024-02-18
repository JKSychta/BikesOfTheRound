extends Control

signal retry

var target: Vector2 = Vector2.ZERO
var current_target: Vector2
var player_position: Vector2
@onready var navigation_arrow: Sprite2D = $NavigationArrow
@onready var time_left: Label = $TimeLeft
var player_health : int
var paused: bool = false
var is_game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOverOverlay.hide()
	$PauseMenuOverlay.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	navigation_arrow.rotation = player_position.angle_to_point(current_target) + deg_to_rad(90)
	if !is_game_over:
		get_input()

func _on_player_player_global_position(player_global_position: Vector2):
	player_position = player_global_position
	
func _on_delivery_spawn_navigation_target_spawn(target: Vector2):
	current_target = target 
	$NavigationArrow.self_modulate = Color.RED

func _on_delivery_system_navigation_target(target: Vector2):
	current_target = target 
	$NavigationArrow.self_modulate = Color.GREEN

func _on_player_health_changed(health: int):
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
	$GameOverOverlay/GameOverJingle.stop()
	is_game_over = false
	get_tree().paused = false
	
func game_over():
	is_game_over = true
	get_tree().paused = true
	$GameOverOverlay.show()
	$GameOverOverlay/VBoxContainer/RetryButton.grab_focus()
	$GameOverOverlay/GameOverJingle.play()
