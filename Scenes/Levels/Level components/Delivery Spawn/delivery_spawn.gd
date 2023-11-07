extends Node2D

var package_pick_up: PackedScene = preload("res://Scenes/PickUps/PackagePickUp/package_pick_up.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_package_pick_up()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_package_pick_up():
	var package = package_pick_up.instantiate()
	add_child(package)
	

