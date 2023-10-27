extends Node2D

@export var attack_damage = 1 
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackAnimation.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func attack(area):
	if area.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
#		attack.knockback_force = knockback_force
		area.damage(attack)


func _on_attack_range_area_entered(area):
	player = area
#	$AttackRange/Countdown.start()
	$AttackAnimation.show()
	$AttackAnimation.play("default")


func _on_attack_range_area_exited(area):
	$AttackAnimation.stop()
	$AttackAnimation.hide()
	player = null
		


func _on_attack_animation_animation_looped():
	attack(player)

