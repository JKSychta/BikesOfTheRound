extends CharacterBody2D


@export var health = 3
@export var point_value = 100
@export var move_speed = 15
var player = null
var inRange := false


func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		if inRange == false && player.invulnerable == false:
			var player_pos = player.position 
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
		$DeathSound.play()
		Global.increaseScore(point_value)
		$ExplosionEffect.show()
		$ExplosionEffect.play("default")
		$CollisionShape2D.set_deferred("disabled", true)
		$DetectionRadius.monitoring = false
		$HitBoxComponent.monitorable = false
		$BotMeleeAttack/AttackRange.monitoring = false
		$deathTimer.start()


func _on_bot_melee_attack_in_range():
	inRange = !inRange



func _on_death_timer_timeout():
	kill()
