extends Node2D
class_name deliveryPoint

signal package_delivered
signal navigationTarget(target:Vector2)

var targetPoint: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.self_modulate = Color(1, 0, 0, 1)
#	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if targetPoint:
		if body.has_method("package_delivered"):
			if body.package_delivered():
				get_tree().call_group("DeliverySystem", "spawn_package_pick_up")
				emit_signal("package_delivered")
				target_point_toggle()

func target_point_toggle():
	targetPoint= !targetPoint
	if targetPoint:
			$Sprite2D.self_modulate = Color(0, 1, 0, 1)
#			self.show()
			emit_signal("navigationTarget", self.global_position)

	else:
			$Sprite2D.self_modulate = Color(1, 0, 0, 1)
#			self.hide()
			
