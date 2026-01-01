class_name SolidBox
extends Area2D

## A solid box that collides with walls and cannot pass through them.


## Initializes the collision layer when the node enters the scene tree.
func _ready():
	# Set collision mask to interact with walls.
	set_collision_mask_value(1, true)
