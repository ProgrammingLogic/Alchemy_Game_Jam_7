class_name WaterParticle
extends RigidBody2D

@onready var sprite: Sprite2D
@onready var water_droplet_texture: Texture2D = preload("res://assets/Drop.png")
@onready var size := Vector2(4, 4)
@onready var collision_rect: RectangleShape2D
@onready var collision_shape: CollisionShape2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D
@onready var physics_material: PhysicsMaterial
@onready var thrust = 1000
@onready var horizontal_force = Vector2(
	(1 if randf() > 0.5 else -1) * thrust,
	0
)



func _ready() -> void:
	_create_sprite()
	_create_collision_rect()
	_create_collision_shape()
	_create_screen_notifier()
	_create_rigid_body()


func _create_sprite() -> void:
	sprite = Sprite2D.new()
	sprite.texture = water_droplet_texture
	add_child(sprite)
	
	
func _create_collision_rect() -> void:
	collision_rect = RectangleShape2D.new()
	collision_rect.size = size
	

func _create_collision_shape() -> void:
	collision_shape = CollisionShape2D.new()
	collision_shape.shape = collision_rect
	add_child(collision_shape)


func _create_screen_notifier() -> void:
	visible_on_screen_notifier_2d = VisibleOnScreenNotifier2D.new()
	visible_on_screen_notifier_2d.screen_exited.connect(
		_on_visible_on_screen_notifier_2d_screen_exited
	)
	
	var visible_on_screen_notifier_2d_rect := Rect2(
		Vector2(0, 0), 
		size,
	)

	visible_on_screen_notifier_2d.rect = visible_on_screen_notifier_2d_rect
	add_child(visible_on_screen_notifier_2d)


func _create_rigid_body() -> void:
	physics_material = PhysicsMaterial.new()
	physics_material.friction = 0.1
	physics_material.bounce = 0.01
	physics_material_override = physics_material

	contact_monitor = true

	gravity_scale = 1.0
	lock_rotation = true
	#linear_damp = 0.5
	mass = 0.1
	
	set_collision_layer_value(1, false) # Not a wall
	set_collision_layer_value(20, true) # We are water
	set_collision_mask_value(20, true) #  We are looking for water


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(linear_velocity)
	
	if not collision:
		return

	var collider: CollisionObject2D = collision.get_collider()

	if collider.get_collision_layer_value(1):
		collision = move_and_collide(horizontal_force)
		
		if not collision:
			return 

		collider = collision.get_collider()
		
		if collider.get_collision_layer_value(1):
			move_and_collide(horizontal_force * -1)
			
		if collider.get_collision_layer_value(20):
			return
			
		

## If the water particle has left the viewport, delete it.
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
