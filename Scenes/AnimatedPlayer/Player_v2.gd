extends CharacterBody2D
##This is the player node 
signal player_global_position(playerGlobalPosition)
signal packageDelivered
signal playerDead
signal healthChanged(health)

#define the distance between front and back based on the sprite
var wheel_base = 16 # 16 is the height of our current sprite
#define the angle at which the wheels will turn
@export var steering_angle_degrees := 20
var steereing_angle = deg_to_rad(steering_angle_degrees)
#the speed whith wich the car will accelerate
@export var speed = 600 ## Speed with which the car will accelerate
@export var braking = -450 ## Speed with which car deccelerate / accelerate backwards
@export var max_speed_reverse = 250 ## Top speed for going in reverse
@export var friction_force = Vector2.ZERO 
@export var drag_force = Vector2.ZERO
@export var slip_speed = 400
## 
@export var traction_fast = 0.1 ##
@export var traction_slow = 0.7 ##
@export var fire_rate: float = 0.5
var Bullet: PackedScene = preload("res://Scenes/Bullet/bullet.tscn")
@onready var muzzle = get_node("BulletSpawn")
#predefined variables
var acceleration := Vector2.ZERO
var steer_angle
var friction: float = -0.9
var drag: float = -0.0015
var angle
var shot_ready :bool = true
var holding_delivery:bool = false
var oldModulate = self.modulate
var flickerSwitch = true

func _ready():
	$FireRate.wait_time = fire_rate
	pass

## Called every phisics engine tick, handles most of the logic
func _physics_process(delta):
	emit_signal("player_global_position", global_position)
	acceleration = Vector2.ZERO
	get_input()
	engineSoundFX()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	var temp_velocity = velocity
	move_and_slide()
	print(velocity.length())
	## Bounce check 
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			velocity = temp_velocity.bounce(collision.get_normal()) * 0.7
	

## Dodaje tarcie dając uczucie stopniowego zwalniania pojazdu gracza
func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	friction_force = velocity * friction
	drag_force = velocity * velocity.length() * drag
	if velocity.length() < 100:
		friction_force *= 3
	acceleration += drag_force + friction_force

#gathering the inputs from user
func get_input():
	var turn = 0
	if Input.is_action_pressed("joy_stick_right"):
		turn += Input.get_action_strength("joy_stick_right")
	if Input.is_action_pressed("turn_right"):
		turn += 1
	if Input.is_action_pressed("joy_stick_left"):
		turn -= Input.get_action_strength("joy_stick_left")
	if Input.is_action_pressed("turn_left"):
		turn -= 1
	steer_angle = turn * steereing_angle
	if Input.is_action_pressed("down"):
		acceleration = transform.x * braking
	if Input.is_action_pressed("joy_brake"):
		acceleration = transform.x * braking * Input.get_action_strength("joy_brake")
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * speed
	if Input.is_action_pressed("joy_accelerate"):
		acceleration = transform.x * speed * Input.get_action_strength("joy_accelerate")
	if Input.is_action_pressed("shoot"):
		shoot()
#	if Input.is_action_just_pressed("escape"):
###		get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
#		if get_tree().paused:
#			get_tree().paused = false
#		else:
#			get_tree().paused = true

		
## Calculations required for steering		
## It establishes the position of front and back "wheels" then uses it to turn the sprite from the front like a vehicle would
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle)*delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.lerp(new_heading * velocity.length(), traction) 
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
	

#Shooting for the player
func shoot():
	if shot_ready:
		var b = Bullet.instantiate() #creates an instance of a Bullet Scene
		owner.add_child(b) #Adds it to the player
	#	b.angle = deg_to_rad(0)
		b.transform = muzzle.global_transform #Shoots it from the BulletSpawn Marker2D
		shot_ready = false
		$FireRate.start()
		$WeponSound.play()

func _on_fire_rate_timeout():
	shot_ready = true

func package_picked_up():
	holding_delivery = true
#	print("AQUIRED PACKAGE")
	
func package_delivered() -> bool:
	if holding_delivery:
		holding_delivery = false
		Global.increaseScore(1000)
		emit_signal('packageDelivered')
		return true
	else:
		return false

func set_player_health():
	$HealthComponent._ready()

func _on_health_component_health_depleated():
	emit_signal('playerDead')


func _on_health_component_health_changed(health):
	$DamgeSound.play()
	emit_signal('healthChanged', health)

func _on_hit_box_component_entity_damaged():
	$HitBoxComponent/CollisionShape2D.disabled = true
	$Invulnerability.start()
	$InvulnerabilityFlicker.start()

func _on_invulnerability_timeout():
	$HitBoxComponent/CollisionShape2D.disabled = false
	$InvulnerabilityFlicker.stop()
	$Sprite2D.modulate = oldModulate


func _on_invulnerability_flicker_timeout():
	if flickerSwitch:
		$Sprite2D.modulate = Color.RED
	else:
		$Sprite2D.modulate = oldModulate
	flickerSwitch = !flickerSwitch
	
func engineSoundFX():
#	var absoluteVelocity = abs(velocity.length())
#	var mappedAbsVelocity = remap(absoluteVelocity, 0, 400, 0, 16)
#	engineSound.pitch_scale = mappedAbsVelocity
	if Input.is_action_pressed("accelerate") || Input.is_action_pressed("joy_accelerate") || Input.is_action_pressed("break") || Input.is_action_pressed("joy_brake"):
		$EngineActive.play()
		$EngineIdle.stop()
	else:
		$EngineActive.stop()
		$EngineIdle.play()
	pass
	

