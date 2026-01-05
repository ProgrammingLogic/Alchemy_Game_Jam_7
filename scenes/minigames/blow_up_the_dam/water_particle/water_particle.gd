class_name WaterParticle
extends RigidBody2D
## A particle that simulates the flow of water.
## 
## The WaterParticle will move downward at flow_rate speed. If the 
## 	WaterParticle hsa a wall under it, pick a direrction (left or
##  right) and flow that direction until there isn't a wall under it.

@export var flow_rate: float = 100

var is_stopped = false
var current_force: Vector2

@onready var area := Area2D.new()
@onready var collision_shape
@onready var collision_shape_2d
@onready var water_droplet_texture: Texture2D = preload("res://scenes/minigames/blow_up_the_dam/water_particle/water_particle.svg")
@onready var sprite_2d
@onready var visible_on_screen_notifier_2d
@onready var physics_material
@onready var horizontal_direction = 0


func _ready() -> void:
	# Collision layers
	set_collision_layer_value(1, false) # We aren't a wall
	set_collision_layer_value(20, true) # We are water
	
	# Randomness
	randomize()
	
	# Sprite2D
	sprite_2d = Sprite2D.new()
	sprite_2d.texture = water_droplet_texture
	add_child(sprite_2d)
	
	# RectangleShape2D / CollisionShape2D
	collision_shape = RectangleShape2D.new()
	collision_shape.size = Vector2(4, 4) # Water particle is 4x4px
	
	collision_shape_2d = CollisionShape2D.new()
	collision_shape_2d.shape = collision_shape
	add_child(collision_shape_2d)
	
	# VisibleOnScreenNotifier2D
	visible_on_screen_notifier_2d = VisibleOnScreenNotifier2D.new()
	visible_on_screen_notifier_2d.screen_exited.connect(
		_on_visible_on_screen_notifier_2d_screen_exited
	)
	
	var visible_on_screen_notifier_2d_rect := Rect2(
		Vector2(0, 0), Vector2(4, 4)
	)
	
	visible_on_screen_notifier_2d.rect = visible_on_screen_notifier_2d_rect
	add_child(visible_on_screen_notifier_2d)
	
	# RigidBody2D
	physics_material = PhysicsMaterial.new()
	physics_material.friction = 0.05
	physics_material_override = physics_material
	
	contact_monitor = true
	
	gravity_scale = 1.0
	lock_rotation = true
	linear_damp = 0.5
	
	# Start by moving down
	current_force = Vector2(0, flow_rate)
	apply_force(current_force)


func _physics_process(delta: float) -> void:
	# We want to get whatever is below us instead of what current_force is,
	# 	because otherwise we see "nothing" to our left/right, and then 
	#	proceed as if there's nothing below us. 
	var collision: KinematicCollision2D = move_and_collide(
		Vector2(0, flow_rate) * delta, true
	)
	var collider: CollisionObject2D = \
		collision.get_collider() if collision\
		else null
		
	# If there is nothing below us, we want to flow downward.
	if not collision:
		current_force = Vector2(0, flow_rate)
		move_and_collide(current_force * delta)
		horizontal_direction = 0
		return

	# 1. We're colliding with a wall, and don't currently have a horizontal direction,
	#	then pick a random direction (left or right), save that direction, and go that
	#	direction.
	# 
	# TODO
	# 1. Check which side of the wall we are closer to, and flow the water
	#	towards that side of the wall.
	if collider.get_collision_layer_value(1) and horizontal_direction == 0:
		horizontal_direction = 1 if randf() > 0.5 else -1
		current_force = Vector2(flow_rate * horizontal_direction, 0)
		
	move_and_collide(current_force * delta)


## If the water particle has left the viewport, delete it.
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
