extends Control

var target = Vector2.ZERO
var currentTarget: Vector2
var playerPosition: Vector2
@onready var navigationArrow = $NavigationArrow
@onready var timeLeft = $TimeLeft
var playerHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	navigationArrow.rotation = playerPosition.angle_to_point(currentTarget) + deg_to_rad(90)
#	print(rad_to_deg(playerPosition.angle_to_point(currentTarget)))
	
#	navigationArrow.rotate(deg_to_rad(15))
	

func _on_player_player_global_position(player_global_position):
	playerPosition = player_global_position
	pass
	

func _on_delivery_spawn_navigation_target_spawn(target):
	currentTarget = target 
	$NavigationArrow.self_modulate = Color.RED
#	print(target)


func _on_delivery_system_navigation_target(target):
	currentTarget = target  # Replace with function body.
	$NavigationArrow.self_modulate = Color.GREEN
#	print(target)


func _on_player_health_changed(health):
	$LivesText.lives = health
