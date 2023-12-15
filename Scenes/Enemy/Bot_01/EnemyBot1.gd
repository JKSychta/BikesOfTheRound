extends CharacterBody2D


@export var health = 3
@export var point_value = 100
@export var move_speed = 15
var player = null


func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
#		var player_pos = player.position
		look_at(player.position)
		velocity = global_position.direction_to(player.global_position) * move_speed
	var tempVelocity = velocity
	move_and_slide()
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			velocity = tempVelocity.bounce(collision.get_normal()) * 1000

func _on_detection_radius_body_entered(body):
	player = body

func _on_detection_radius_body_exited(body):
	player = null


#func _on_tree_exited():
#	Global.increaseScore(point_value)
#	print(Global.score)

func kill():
	queue_free()


func _on_health_component_health_depleated():
		Global.increaseScore(point_value)
		queue_free()
