extends Node2D

var target: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		pass
	else:
		look_at(target.global_position)
	print(target)
#	look_at(get_global_mouse_position())


func set_target(newTarget: Node2D):
	target = newTarget
