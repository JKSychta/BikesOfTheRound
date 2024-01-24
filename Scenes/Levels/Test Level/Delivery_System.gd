extends Node

signal navigationTarget(target)
@onready var deliveryPoints= get_tree().get_nodes_in_group("DeliveryPoints")

func choose_destination():
	var randomPoint = randi_range(0, len(deliveryPoints)-1)
	var selectedPoint = deliveryPoints[randomPoint]
	if selectedPoint.has_method('target_point_toggle'):
		selectedPoint.target_point_toggle()
		emit_signal("navigationTarget", selectedPoint.global_position)
	

func deselect_all():
	for i in range(len(deliveryPoints)):
		var deliveryPoint = deliveryPoints[i]
		if deliveryPoint.targetPoint == true:
			deliveryPoint.target_point_toggle()
		
func _on_delivery_spawn_delivery_point_select():
	choose_destination()
