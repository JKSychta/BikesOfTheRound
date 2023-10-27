extends CharacterBody2D
@export var health = 3
@export var point_value = 100
@export var move_speed = 15
var player = null


func  _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		look_at(player.position)
		velocity = position.direction_to(player.position) * move_speed
	move_and_slide()

func _on_detection_radius_body_entered(body):
	player = body

func _on_detection_radius_body_exited(body):
	player = null


func _on_tree_exited():
	Global.score += point_value
	print(Global.score)
