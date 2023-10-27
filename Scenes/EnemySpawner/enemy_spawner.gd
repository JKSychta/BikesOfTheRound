extends Node2D

signal everybody_dead

@export var Enemy: PackedScene = preload("res://Scenes/Enemy/Bot_01/Enemy_bot1.tscn")
@export var enemy_count: int = 5
@onready var timer = $RespawnTimer
@onready var timer_label = $TimeDisplayLabel
var alive_enemies_count: int

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn(enemy_count)
	timer_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_child_count())


func spawn(amount = 1):
	for i in range(amount):
		var e = Enemy.instantiate()
		add_child(e)
		e.position = self.position + randomSpawnPoint()
	alive_enemies_count = amount

func randomSpawnPoint():
	var angle := randi_range(0, PI)
	var distance := randi_range(0, $Area2D/CollisionShape2D.shape.radius / 2)
	return distance * Vector2.from_angle(angle)


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
