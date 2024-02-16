extends Node2D

signal deliveryPointSelect
signal navigationTargetSpawn(target)

@onready var PackagePickUp: PackedScene = preload("res://Scenes/PickUps/PackagePickUp/package_pick_up.tscn")


func spawn_package_pick_up():
	self.show()
	var package = PackagePickUp.instantiate()
	package.package_picked_up.connect(on_package_picked_up)
	add_child(package)
	emit_signal('navigationTargetSpawn', global_position)
	
func on_package_picked_up():
	emit_signal("deliveryPointSelect")
	self.hide()

