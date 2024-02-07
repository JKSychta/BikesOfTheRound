## This is the main timer that controlls the time left in a session
extends Timer

@export var defaultTimer: float = 10
@export var deliveryBonusTime: float = 10
var ui


# Called when the node enters the scene tree for the first time.
func _ready():
	ui = get_parent().get_node("Player/CanvasLayer/User_Interface")
	resetToDefault()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ui.time_left.text = str(int(self.time_left))
	if time_left < wait_time/3:
		ui.time_left.modulate = Color.DARK_RED
	else:
		ui.time_left.modulate = Color.WHITE

## This function adds more time to the session
func add_time(bonusTime):
	self.wait_time = time_left + bonusTime
	self.start()

## This function adds time uppon reciving a signal emited from a player after delivering a package
func _on_player_package_delivered():
	add_time(deliveryBonusTime)

func resetToDefault():
	wait_time = defaultTimer
