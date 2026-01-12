class_name DestructablePolygonWall
extends Polygon2D
## Wall in the shape of a Polygon.
##
## Polygonal shape that acts as a "wall", preventing objects from moving through it.


@onready var static_body: StaticBody2D
@onready var collision_polygon: CollisionPolygon2D
@onready var area: Area2D


func _ready() -> void:
	if get_polygon().is_empty():
		print("ERROR: DestructablePolygonWall parent has no verticies!")
		return
	
	collision_polygon = _create_collision_polygon()

	static_body = _create_static_body(collision_polygon)
	add_child(static_body)

	area = _create_area(collision_polygon)


func _create_collision_polygon() -> CollisionPolygon2D:
	var c_polygon := CollisionPolygon2D.new()
	c_polygon.set_polygon(get_polygon())

	return c_polygon


func _create_static_body(c_polygon: CollisionPolygon2D) -> StaticBody2D:
	var s_body := StaticBody2D.new()
	s_body.set_collision_layer_value(1, false) # Wall
	s_body.set_collision_mask_value(3, true) # Bomb
	s_body.set_collision_mask_value(20, true) # Water

	s_body.add_child(c_polygon)

	return s_body


func _create_area(c_polygon: CollisionPolygon2D) -> Area2D:
	var area := Area2D.new()
	area.add_child(c_polygon)

	return area
