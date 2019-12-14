extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	var input_direction = Vector2(0,-1)
	var grid = get_node("/root/Game/Grid")
	grid.move_with_direction(input_direction)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
