class_name WaterParticle
extends RigidBody2D

@onready var _collision_shape_2d := CollisionShape2D.new()
@onready var _water_droplet_texture: Texture2D = preload("res://scenes/minigames/blow_up_the_dam/water_particle/water_particle.svg")
@onready var _sprite_2d := Sprite2D.new()
@onready var _visible_on_screen_notifier_2d := VisibleOnScreenNotifier2D.new()

signal stopped_at_wall


func _ready() -> void:
	_initialize_components()
	
func _initialize_components() -> void:
	# CollisionShape2D
	var _collision_shape := RectangleShape2D.new()
	_collision_shape.size = Vector2(4, 4) # Water particle is 4x4px
	
	_collision_shape_2d.shape = _collision_shape
	add_child(_collision_shape_2d)
	
	# Sprite2D
	_sprite_2d.texture = _water_droplet_texture
	add_child(_sprite_2d)
	
	# VisibleOnScreenNotifier2D
	_visible_on_screen_notifier_2d.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	var _visible_on_screen_notifier_2d_rect := Rect2(Vector2(0, 0), Vector2(4, 4))
	_visible_on_screen_notifier_2d.rect = _visible_on_screen_notifier_2d_rect
	add_child(_visible_on_screen_notifier_2d)
	
	# RigidBody2D
	var _physics_material := PhysicsMaterial.new()
	_physics_material.friction = 0.05
	physics_material_override = _physics_material
	
	gravity_scale = 1.0
	lock_rotation = true
	linear_damp = 0.5
	
	sleeping_state_changed.connect(_on_sleeping_state_changed) # We need to know when we've stopped moving

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_sleeping_state_changed() -> void:
	if sleeping:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(
			global_position,
			global_position + Vector2(0, 4), # Collision rect is 4 tall, so whatever we're colliding with will be 4 down
		)
		var result = space_state.intersect_ray(query)
		
		if result:
			var object_collided_with: Object = result.collider
			
			if object_collided_with is WallBox:
				_on_stopped_at_wall(object_collided_with, result.position)
				
				
func _on_stopped_at_wall(wall: WallBox, position: Vector2):
	var wall_shape = wall.shape
	var wall_rect: Rect2 = wall_shape.get_rect()
	var wall_global_position = wall.global_position
	var wall_center = wall_rect.get_center()

	
	var wall_size = wall_rect.size
	var wall_size_halfed = wall_size / 2
	
	var wall_left_corner = wall_global_position - wall_size_halfed
	var wall_right_corner = wall_global_position + wall_size_halfed
	
	var distance_from_left_corner = global_position - wall_left_corner
	var distance_from_right_corner = global_position - wall_right_corner
	
	# prefer left corner
	if distance_from_left_corner >= distance_from_right_corner:
		print("left corner is closer")
	elif distance_from_right_corner > distance_from_left_corner:
		print("right corner is closer")
			
