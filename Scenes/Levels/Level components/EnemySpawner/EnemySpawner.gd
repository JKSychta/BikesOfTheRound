extends Node2D

@export var Enemy: PackedScene = preload("res://Scenes/Enemy/Bot_01/EnemyBot1.tscn")
@export var enemy_count: int = 5
@export var respawn_time: int = 10
@onready var timer = $RespawnTimer
@onready var area_radius = $Area2D/CollisionShape2D.shape.radius


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = respawn_time
	timer.start()

func spawn():
	for i in range(enemy_count):
		var e = Enemy.instantiate()
		add_child(e)
		e.position += Vector2(random_spawn_point(), random_spawn_point())

func random_spawn_point() -> float:
	var distance: float = randi_range(-area_radius, area_radius)	
	return distance

func _on_respawn_timer_timeout():
	spawn()
	timer.start()

func kill_all():
	for i in range(get_child_count()):
		var child = get_child(i)
		if child.has_method('kill'):
			child.kill()


