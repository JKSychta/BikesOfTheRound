extends Node2D

signal everybody_dead

@export var Enemy: PackedScene = preload("res://Scenes/Enemy/Bot_01/EnemyBot1.tscn")
@export var enemy_count: int = 5
@export var respawn_time: int = 10
@onready var timer = $RespawnTimer
@onready var timer_label = $TimeDisplayLabel
var alive_enemies_count: int
@onready var area_radius = $Area2D/CollisionShape2D.shape.radius
var start_timer_check: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()
	timer.wait_time = respawn_time
#	timer_label.hide()
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	print(get_child_count())

func spawn():
	start_timer_check = false
	for i in range(enemy_count):
		var e = Enemy.instantiate()
		add_child(e)
		e.position += Vector2(randomSpawnPoint(), randomSpawnPoint())
	alive_enemies_count = enemy_count

func randomSpawnPoint():
	var distance := randi_range(-area_radius, area_radius)	
	return distance


func _on_respawn_timer_timeout():
	spawn()
#	timer_label.hide()#
	timer.start()


func _on_child_exiting_tree(node):
	alive_enemies_count -= 1
	if alive_enemies_count <= 0:
		emit_signal("everybody_dead")


func _on_everybody_dead():
	pass
#	if start_timer_check:
#		timer.start()
#		timer_label.show()
		
func kill_all():
	start_timer_check = false
	for i in range(get_child_count()):
		var child = get_child(i)
		if child.has_method('kill'):
			child.kill()
	spawn()
