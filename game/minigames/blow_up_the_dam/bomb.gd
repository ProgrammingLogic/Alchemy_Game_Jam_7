class_name Bomb
extends Polygon2D


@onready var radius: float = 14.0
@onready var sides: int = 4
@onready var bomb_asset = preload("res://assets/bomb_explosion.tres")
@onready var bomb_sprite: AnimatedSprite2D
@onready var static_body: StaticBody2D
@onready var collision_polygon: CollisionPolygon2D
@onready var area: Area2D

signal explosion_completed


func _init(pos: Vector2):
	position = pos
	color = Color(0, 0, 0, 0)


func _ready():
	_create()
	start_explosion()        


func _create():
	set_polygon(_calculate_points())
	_create_collision_polygon()
	_create_static_body()
	_create_bomb_sprite()
	_create_area()


func _calculate_points() -> Array[Vector2]:
	var points: Array[Vector2] = []

	for i in sides:
		var angle = i * TAU / sides

		points.append(
			Vector2(cos(angle), sin(angle)) *
			radius
		)

	return points


func _create_bomb_sprite() -> void:
	bomb_sprite = AnimatedSprite2D.new()
	bomb_sprite.set_sprite_frames(bomb_asset)
	bomb_sprite.speed_scale = 2
	bomb_sprite.animation_finished.connect(_on_animation_finished)
	add_child(bomb_sprite)
	
	
func _create_collision_polygon() -> void:
	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.set_polygon(get_polygon())
	add_child(collision_polygon)


func _create_static_body() -> void:
	static_body = StaticBody2D.new()

	static_body.set_collision_layer_value(1, false) # Wall
	static_body.set_collision_layer_value(3, true) # Bomb
	static_body.set_collision_mask_value(2, true) # Destructable

	static_body.add_child(collision_polygon)
	add_child(static_body)
	

func _create_area() -> void:
	area = Area2D.new()

	area.set_collision_layer_value(1, false) # Wall
	area.set_collision_layer_value(3, true) # Bomb
	area.set_collision_mask_value(2, true) # Destructable

	area.add_child(collision_polygon.duplicate())
	add_child(area)


func _on_animation_finished() -> void:
	for p in get_colliding_destructable_polygons():
		print(p)
		p.destroy(self)
	
	
func get_colliding_destructable_polygons() -> Array[Polygon2D]:
	var result: Array[Polygon2D] = []
	
	for a in area.get_overlapping_areas():
		if not a.get_collision_layer_value(2): # Destructable
			continue

		var parent = a.get_parent()
			
		if not parent is Polygon2D:
			continue

		result.append(parent)

	return result


func delete() -> void:
	queue_free()


func start_explosion() -> void:
	if bomb_sprite:
		bomb_sprite.play()
