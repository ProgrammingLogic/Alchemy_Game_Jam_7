class_name WallBox
extends StaticBody2D

## A box that acts a wall, preventing other objects from passing through it.


## Initializes the collision layer when the node enters the scene tree.
func _ready():
	# Set collision layer to act as a wall.
	set_collision_layer_value(1, true)
