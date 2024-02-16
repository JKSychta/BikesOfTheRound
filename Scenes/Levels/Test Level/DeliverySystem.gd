extends Node

signal navigationTarget(target)
@onready var delivery_points := get_tree().get_nodes_in_group("DeliveryPoints")
# Called when the node enters the scene tree for the first time.

func choose_destination():
	var random_point = randi_range(0, len(delivery_points)-1)
	var selected_point = delivery_points[random_point]
	if selected_point.has_method('target_point_toggle'):
		selected_point.target_point_toggle()
		emit_signal("navigationTarget", selected_point.global_position)
	

func deselect_all():
	for i in range(len(delivery_points)):
		var delivery_point = delivery_points[i]
		if delivery_point.target_point == true:
			delivery_point.target_point_toggle()
		
func _on_delivery_spawn_delivery_point_select():
	choose_destination()
