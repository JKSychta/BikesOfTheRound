extends Node

signal navigationTarget(target)
@onready var delivery_points := get_tree().get_nodes_in_group("DeliveryPoints")
# Called when the node enters the scene tree for the first time.

func choose_destination():
	var randomPoint = randi_range(0, len(delivery_points)-1)
	var selectedPoint = delivery_points[randomPoint]
	if selectedPoint.has_method('target_point_toggle'):
		selectedPoint.target_point_toggle()
		emit_signal("navigationTarget", selectedPoint.global_position)
	

func deselect_all():
	for i in range(len(delivery_points)):
		var deliveryPoint = delivery_points[i]
		if deliveryPoint.targetPoint == true:
			deliveryPoint.target_point_toggle()
		
func _on_delivery_spawn_delivery_point_select():
	choose_destination()
