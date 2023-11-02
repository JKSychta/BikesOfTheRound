extends Node2D
signal package_picked_up

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	emit_signal("package_picked_up") # Replace with function body.
	if body.has_method("package_picked_up"):
		body.package_picked_up()
		queue_free()
