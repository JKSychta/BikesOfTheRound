extends CharacterBody2D

@export var attack_damage: int = 3
#@export var knockback_force = 10 
var speed: int = 400


# Called every frame. 'delta' is the elapsed time since the  previous frame.
func _physics_process(delta):
	position += transform.y * speed * delta

	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hit_box_component_body_entered(body):
	if body.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		body.damage(attack)
	queue_free()


func _on_hit_box_component_area_entered(area):
	if area.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		area.damage(attack)
	queue_free() 
