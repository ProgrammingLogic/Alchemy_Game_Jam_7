class_name WaterParticle
extends RigidBody2D

@onready var _area := Area2D.new()
@onready var _collision_shape_2d := CollisionShape2D.new()
@onready var _water_droplet_texture: Texture2D = preload("res://scenes/minigames/blow_up_the_dam/water_particle/water_particle.svg")
@onready var _sprite_2d := Sprite2D.new()
@onready var _visible_on_screen_notifier_2d := VisibleOnScreenNotifier2D.new()
@onready var _line_to_top_left_corner: Line2D
@onready var _line_to_top_right_corner: Line2D
@onready var _flow_rate: float = 50
@onready var _target_corner # Cannot be typed as Vector2, otherwise it gives an error when null

signal stopped_at_wall


func _ready() -> void:
	_line_to_top_left_corner = Line2D.new()
	add_child(_line_to_top_left_corner)
	_line_to_top_right_corner = Line2D.new()
	add_child(_line_to_top_right_corner)

	_initialize_components()
	
func _physics_process(delta: float) -> void:
	if _target_corner != null:
		if global_position.distance_to(_target_corner) <= _flow_rate * delta:
			global_position = _target_corner
			linear_velocity = Vector2(0, _flow_rate)
			_target_corner = null
			gravity_scale = 1.0
			
		else:
			var direction: Vector2 = (_target_corner - global_position).normalized()
			linear_velocity = direction * _flow_rate
	
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
	contact_monitor = true
	body_shape_entered.connect(_on_area_entered)
	
	gravity_scale = 1.0
	lock_rotation = true
	linear_damp = 0.5
	#sleeping_state_changed.connect(_on_sleeping_state_changed) # We need to know when we've stopped moving
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	print("area entered")
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + Vector2(0, 4), # Collision rect is 4 tall, so whatever we're colliding with will be 4 down
	)
	query.exclude=[self]
	var result = space_state.intersect_ray(query)
	
	if result:
		var object_collided_with: Object = result.collider
		
		if object_collided_with is WallBox:
			_on_stopped_at_wall(object_collided_with, result.position)

#func _on_sleeping_state_changed() -> void:
	#if sleeping:
		#var space_state = get_world_2d().direct_space_state
		#var query = PhysicsRayQueryParameters2D.create(
			#global_position,
			#global_position + Vector2(0, 4), # Collision rect is 4 tall, so whatever we're colliding with will be 4 down
		#)
		#query.exclude=[self]
		#var result = space_state.intersect_ray(query)
		#
		#if result:
			#var object_collided_with: Object = result.collider
			#
			#if object_collided_with is WallBox:
				#_on_stopped_at_wall(object_collided_with, result.position)
				
				
func _on_stopped_at_wall(wall: WallBox, position: Vector2):
	var wall_top_left_corner: Vector2 = wall.top_left_corner.global_position
	var wall_top_right_corner: Vector2 = wall.top_right_corner.global_position
	

	_line_to_top_left_corner.show()
	_line_to_top_left_corner.add_point(to_local(wall_top_left_corner))
	_line_to_top_left_corner.add_point(to_local(global_position))
	_line_to_top_left_corner.default_color = Color.RED
	_line_to_top_left_corner.width = 0.5
	
	_line_to_top_right_corner.show()
	_line_to_top_right_corner.add_point(to_local(wall_top_right_corner))
	_line_to_top_right_corner.add_point(to_local(global_position))
	_line_to_top_right_corner.default_color = Color.RED
	_line_to_top_right_corner.width = 0.5
	
	
	var distance_from_left_corner: Vector2 = global_position - wall_top_left_corner
	var distance_from_right_corner: Vector2 = global_position - wall_top_right_corner
	
	print("distance to left corner: ", global_position.distance_to(wall_top_left_corner))
	print("distance to right corner: ", global_position.distance_to(wall_top_right_corner))
	
	if global_position.distance_to(wall_top_left_corner) <= global_position.distance_to(wall_top_right_corner):
		_target_corner = wall_top_left_corner + Vector2(-6, 0)
		print("left corner is closer")
	else:
		_target_corner = wall_top_right_corner + Vector2(6, 0)
		print("right corner is closer")
