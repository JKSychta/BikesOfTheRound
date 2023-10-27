extends CharacterBody2D

var Bullet: PackedScene = preload("res://Scenes/Bullet/bullet.tscn")
@onready var muzzle = get_node("BulletSpawn")

func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = muzzle.global_transform

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
