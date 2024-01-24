extends CharacterBody2D
##This is the player node 
signal player_global_position(playerGlobalPosition)
signal packageDelivered
signal playerDead
signal healthChanged(health)

#define the distance between front and back based on the sprite
var wheelBase = 16 # 16 is the height of our current sprite
#define the angle at which the wheels will turn
@export var steeringAngleDegrees := 20
var steeringAngle = deg_to_rad(steeringAngleDegrees)
#the speed whith wich the car will accelerate
@export var speed: int = 600 ## Speed with which the car will accelerate
@export var braking: int = -450 ## Speed with which car deccelerate / accelerate backwards
@export var maxSpeedReverse: int = 250 ## Top speed for going in reverse
@export var frictionForce: Vector2 = Vector2.ZERO 
@export var dragForce: Vector2 = Vector2.ZERO
@export var slipSpeed: int = 400
## 
@export var tractionFast: float = 0.1 ##
@export var tractionSlow: float = 0.7 ##
@export var fireRate: float = 0.5
var Bullet: PackedScene = preload("res://Scenes/Bullet/bullet.tscn")
@onready var muzzle: Marker2D = get_node("BulletSpawn")
#predefined variables
var acceleration: Vector2 = Vector2.ZERO
var steerAngle: float
var friction: float = -0.9
var drag: float = -0.0015
var angle: float
var shotReady: bool = true
var holdingDelivery: bool = false
var oldModulate: Color = self.modulate
var flickerSwitch: bool = true

func _ready():
	$FireRate.wait_time = fireRate
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
	var tempVelocity = velocity
	move_and_slide()
	print(velocity.length())
	## Bounce check 
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		if collision != null:
			velocity = tempVelocity.bounce(collision.get_normal()) * 0.7
	

## Dodaje tarcie dając uczucie stopniowego zwalniania pojazdu gracza
func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	frictionForce = velocity * friction
	dragForce = velocity * velocity.length() * drag
	if velocity.length() < 100:
		frictionForce *= 3
	acceleration += dragForce + frictionForce

## Gathering the inputs from user
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
	steerAngle = turn * steeringAngle
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

		
## Calculations required for steering		
## It establishes the position of front and back "wheels" then uses it to turn the sprite from the front like a vehicle would
func calculate_steering(delta):
	var rearWheel = position - transform.x * wheelBase / 2.0
	var frontWheel = position + transform.x * wheelBase / 2.0
	rearWheel += velocity * delta
	frontWheel += velocity.rotated(steerAngle)*delta
	var newHeading = (frontWheel - rearWheel).normalized()
	var traction = tractionSlow
	if velocity.length() > slipSpeed:
		traction = tractionFast
	var d = newHeading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.lerp(newHeading * velocity.length(), traction) 
	if d < 0:
		velocity = -newHeading * min(velocity.length(), maxSpeedReverse)
	rotation = newHeading.angle()
	

#Shooting for the player
func shoot():
	if shotReady:
		var b = Bullet.instantiate() #creates an instance of a Bullet Scene
		owner.add_child(b) #Adds it to the player
	#	b.angle = deg_to_rad(0)
		b.transform = muzzle.global_transform #Shoots it from the BulletSpawn Marker2D
		shotReady = false
		$FireRate.start()
		$WeponSound.play()


func _on_fire_rate_timeout():
	shotReady = true

func package_picked_up():
	holdingDelivery = true
#	print("AQUIRED PACKAGE")
	
func package_delivered() -> bool:
	if holdingDelivery:
		holdingDelivery = false
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
	if Input.is_action_pressed("accelerate") || Input.is_action_pressed("joy_accelerate") || Input.is_action_pressed("break") || Input.is_action_pressed("joy_brake"):
		$EngineActive.play()
		$EngineIdle.stop()
	else:
		$EngineActive.stop()
		$EngineIdle.play()
	pass
	



