extends CharacterBody2D

#define the distance between front and back based on the sprite
var wheel_base = 32 # 16 is the height of our current sprite
#define the angle at which the wheels will turn
@export var steereing_angle = deg_to_rad(15)
#the speed whith wich the car will accelerate
@export var speed = 1000
@export var braking = -450
@export var max_speed_reverse = 250
@export var friction_force = Vector2.ZERO
@export var drag_force = Vector2.ZERO
@export var slip_speed = 400
@export var traction_fast = 0.1
@export var traction_slow = 0.7
@export var fire_rate: float = 0.5
var Bullet: PackedScene = preload("res://Scenes/Bullet/bullet.tscn")
@onready var muzzle = get_node("BulletSpawn")
#predefined variables
var acceleration = Vector2.ZERO
var steer_angle
var friction = -0.9
var drag = -0.0015
var angle
var shot_ready :bool = true



func _ready():
	$FireRate.wait_time = fire_rate
	pass

#called every phisics engine tick
func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
#	print("Acceleration:", acceleration.length())
#	print("Velocity:", velocity.length())
#	animate_sprite()
	move_and_slide()
	

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
	if Input.is_action_pressed("turn_right"):
		turn += 1
	if Input.is_action_pressed("turn_left"):
		turn -= 1
	steer_angle = turn * steereing_angle
	if Input.is_action_pressed("down"):
		acceleration = transform.x * braking
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * speed
	if Input.is_action_pressed("shoot"):
		shoot()


		
#Calculations required for steering		
#It establishes the position of front and back "wheels" then uses it to turn the sprite from the front like a vehicle would
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

func _on_fire_rate_timeout():
	shot_ready = true


#func animate_sprite():
#	var car_direction =
#	print(car_direction)
#	angle = snapped(rotation, PI/4) / (PI/4)
##	print(angle)
#	angle = wrapi(int(angle), 0, 8)
##	print(angle)
#	$AnimatedSprite2D.animation = "8dirtest"
#	$AnimatedSprite2D.frame = angle
#
