extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# the spawn point
func _on_delivery_point_navigation_target(target:Vector2):
	$NavigationArrow.set_target(target)
#	pass
	


# the delivery spawn point
func _on_delivery_spawn_navigation_target(target:Vector2):
	$NavigationArrow.set_target(target)
#	pass
