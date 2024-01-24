extends Area2D

signal entityDamaged
@export var healthComponent : HealthComponent

func damage(attack: Attack):
	if healthComponent:
		healthComponent.damage(attack)
		emit_signal('entityDamaged')
