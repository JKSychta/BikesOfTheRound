extends CharacterBody2D

@export var speed = 300
@export var rotation_speed = 3
@export var acceleration = 3000
@export var friction = (acceleration / speed) / 5
@export var max_speed = 2000
@export var break_friction = (acceleration / speed) * 4
var Bullet: PackedScene = preload("res://Scenes/Bullet/bullet.tscn")
@onready var muzzle = get_node("BulletSpawn")

var rotation_direction = 0
	
func get_input():
	rotation_direction = Input.get_axis("turn_left", "turn_right")
	#velocity = transform.y * Input.get_axis("accelerate", "down") * speed
	#inputs to set rotation of a character
	var angle_deg = round(rad_to_deg(rotation_direction))
	print(angle_deg)
	if Input.is_action_just_pressed("shoot"):
		shoot()
		print("Bang!")
	if Input.is_action_just_pressed("rot 0"):
		rotation = 0
	if Input.is_action_just_pressed("rot 1"):
		rotation = 1
	if Input.is_action_just_pressed("rot 2"):
		rotation = 2
	if Input.is_action_just_pressed("rot 3"):
		rotation = 3.25

func _physics_process(delta):
	get_input()
	#apply_friction(delta)
	apply_breaks(delta)	
	apply_traction(delta)
	rotation += rotation_direction * rotation_speed * delta
	#print("Rotation:", rotation)
	#print("Velocity:", velocity)
	move_and_slide()


func apply_traction(delta) -> void:
	var traction = Vector2()
	if Input.is_action_pressed("accelerate"):
		traction.y -= 1
	if Input.is_action_pressed("down"):
		traction.y += 1
	
	traction = traction.normalized()
	velocity += transform.y * Input.get_axis("accelerate", "down") * acceleration * delta
	if velocity.y >= max_speed:
		velocity.y = max_speed

func apply_friction(delta) -> void:
	velocity -= velocity * friction * delta

func apply_breaks(delta):
	if Input.is_action_just_pressed("break"):
			velocity -= velocity * break_friction * delta
	else:
		apply_friction(delta) 
		
		
func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	print(owner.get_child_count())
	b.transform = muzzle.global_transform
