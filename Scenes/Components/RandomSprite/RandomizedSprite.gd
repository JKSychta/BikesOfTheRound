extends Sprite2D

var frames = texture.get_width() / region_rect.size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_index = randi_range(0, frames - 1)
	region_rect.position.x = random_index * region_rect.size.x

