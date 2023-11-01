extends Node2D

signal everybody_dead

@export var Enemy: PackedScene = preload("res://Scenes/Enemy/Bot_01/Enemy_bot1.tscn")
@export var enemy_count: int = 5
@export var respawn_time = 10
@onready var timer = $RespawnTimer
@onready var timer_label = $TimeDisplayLabel
var alive_enemies_count: int
@onready var area_radius = $Area2D/CollisionShape2D.shape.radius

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn(enemy_count)
	timer.wait_time = respawn_time
	timer_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	print(get_child_count())

func spawn(amount = 1):
	for i in range(amount):
		var e = Enemy.instantiate()
		add_child(e)
		e.position += Vector2(randomSpawnPoint(), randomSpawnPoint())
	alive_enemies_count = amount

func randomSpawnPoint():
	var distance := randi_range(-area_radius, area_radius)	
	return distance


func _on_respawn_timer_timeout():
	spawn(enemy_count)
	timer_label.hide()


func _on_child_exiting_tree(node):
	alive_enemies_count -= 1
	if alive_enemies_count <= 0:
		emit_signal("everybody_dead")


func _on_everybody_dead():
		timer.start()
		timer_label.show()
