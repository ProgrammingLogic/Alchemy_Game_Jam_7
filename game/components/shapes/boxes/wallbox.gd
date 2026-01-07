class_name WallBox
extends StaticBody2D

@export var collision_shape: CollisionShape2D
@export var shape: Shape2D

## A box that acts a wall, preventing other objects from passing through it.

## Initializes the collision layer when the node enters the scene tree.
func _ready():
	#var the_shape: Shape2D = collision_shape.shape
	shape = $CollisionShape2D.shape
	set_collision_layer_value(1, true) # Set collision layer to act as a wall.
