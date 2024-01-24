extends Node2D

signal deliveryPointSelect
signal navigationTargetSpawn(target)

@onready var packagePickUp: PackedScene = preload("res://Scenes/PickUps/PackagePickUp/package_pick_up.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#spawn_package_pick_up()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_package_pick_up():
	self.show()
	var package = packagePickUp.instantiate()
	package.package_picked_up.connect(on_package_picked_up)
	add_child(package)
	emit_signal('navigationTargetSpawn', global_position)
	
func on_package_picked_up():
	emit_signal("deliveryPointSelect")
	self.hide()

