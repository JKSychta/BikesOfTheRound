extends Timer
var ui

# Called when the node enters the scene tree for the first time.
func _ready():
	ui = get_parent().get_node("Player/Camera2D/CanvasLayer/User_Interface")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ui.timeLeft.text = str(int(self.time_left))
	if time_left < wait_time/3:
		ui.timeLeft.modulate = Color.DARK_RED
	else:
		ui.timeLeft.modulate = Color.WHITE


func _on_player_package_delivered():
	pass
