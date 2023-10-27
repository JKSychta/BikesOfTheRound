extends Label

@export var timer: Timer

func _process(delta):
	self.text = str(snapped(timer.time_left, 0.1))
