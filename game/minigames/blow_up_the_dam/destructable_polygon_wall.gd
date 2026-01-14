class_name DestructablePolygonWall
extends Polygon2D
## Wall in the shape of a Polygon.
##
## Polygonal shape that acts as a "wall", preventing objects from moving through it.

@onready var collision_polygon: CollisionPolygon2D
@onready var static_body: StaticBody2D
@onready var area: Area2D


func _ready() -> void:
	if get_polygon().is_empty():
		print("ERROR: DestructablePolygonWall parent has no verticies!")
		return
	
	_create()


func _create() -> void:
	_create_collision_polygon()
	_create_static_body()
	_create_area()


func _create_collision_polygon() -> void:
	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.set_polygon(get_polygon())
	add_child(collision_polygon)


func _create_static_body() -> void:
	if not collision_polygon:
		print("ERROR: collision_polygon is not defined when creating static_body")
		return 

	static_body = StaticBody2D.new()
	static_body.set_collision_layer_value(1, true) # Wall
	static_body.set_collision_layer_value(2, true) # Destructable
	static_body.set_collision_mask_value(3, true) # Bomb
	static_body.set_collision_mask_value(20, true) # Water

	static_body.add_child(collision_polygon.duplicate())
	add_child(static_body)


func _create_area() -> void:
	if not collision_polygon:
		print("ERROR: collision_polygon is not defined when creating area")
		return

	area = Area2D.new()

	enable_hitbox()
	area.set_collision_layer_value(1, true) # Wall
	area.set_collision_layer_value(2, true) # Destructable
	area.set_collision_mask_value(3, true) # Bomb
	area.set_collision_mask_value(20, true) # Water

	area.add_child(collision_polygon.duplicate())
	add_child(area)


func enable_hitbox() -> void:
	area.monitorable = true


func disable_hitbox() -> void:
	area.monitorable = false
	

func destroy(destroy_poly: Polygon2D) -> void:
	var destroy_poly_global := destroy_poly.global_transform * destroy_poly.polygon

	var clipped: Array[PackedVector2Array] = Geometry2D.clip_polygons(
		get_polygon(),
		destroy_poly_global
		#destroy_poly.get_polygon()
	)
	
	print(get_polygon())
	print(destroy_poly.global_transform * destroy_poly.get_polygon())
	print(clipped)

	# No remaining polygon
	if clipped.is_empty():
		print("polygon is gone")
		queue_free()
		return

	# Only one Polygon
	if clipped.size() == 1:
		print('only one polygone')
		change_size(clipped[0])
		return

	print("splitting into fragments")
	split_into_fragments(get_polygon(), destroy_poly_global)
		
		
func change_size(new_polygon: PackedVector2Array):
	pass
	
	
func split_into_fragments(original: PackedVector2Array, hole: PackedVector2Array):
	var parent = get_parent()

	# Scenario: Hole only has 4 points, and we know those points are inside our Polygon
	#

	


	# Find points that 


	

	
	queue_free()
