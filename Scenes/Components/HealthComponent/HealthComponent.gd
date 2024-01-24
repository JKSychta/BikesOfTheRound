extends Node2D
class_name HealthComponent


signal healthDepleated
signal healthChanged(health: int)

@export var START_HEALTH := 10
var health: int

func _ready():
	health = START_HEALTH
	emit_signal('healthChanged', health)

func damage(attack: Attack):
	health -= attack.attack_damage
	emit_signal('healthChanged', health)
	if health <= 0:
		emit_signal('healthDepleated')

func heal(healValue := 1):
	health += healValue
	emit_signal('healthChanged', health)
