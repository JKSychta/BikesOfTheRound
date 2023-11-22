extends Label

var lives: int = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "X " + str(lives)
