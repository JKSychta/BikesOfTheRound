extends Node2D
class_name deliveryPoint

signal package_delivered
#signal navigationTarget(target)

var targetPoint: bool = false
var target: Vector2 = self.global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

func _on_area_2d_body_entered(body):
	if targetPoint:
		if body.has_method("package_delivered"):
			if body.package_delivered():
				get_tree().call_group("DeliverySystem", "spawn_package_pick_up")
				emit_signal("package_delivered")
				target_point_toggle()

func target_point_toggle():
	targetPoint = !targetPoint
	if targetPoint:
			self.show()
	else:
			self.hide()
			
