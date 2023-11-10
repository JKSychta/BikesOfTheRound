extends Node2D

var target: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == Vector2.ZERO:
		pass
	else:
		look_at(target)
	print(target)
#	look_at(get_global_mouse_position())


func set_target(newTarget:Vector2):
	target = newTarget
