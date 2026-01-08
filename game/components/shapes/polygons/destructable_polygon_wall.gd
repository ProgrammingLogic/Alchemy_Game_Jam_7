class_name DestructablePolygonWall
extends Area2D
## Wall in the shape of a Polygon.
##
## Polygonal shape that acts as a "wall", preventing objects from moving through it.


@onready var static_body: StaticBody2D
@onready var parent_polygon_2d: Polygon2D
@onready var polygon_2d: Polygon2D
@onready var collision_polygon: CollisionPolygon2D
@onready var collision_layers: Dictionary
@onready var collision_masks: Dictionary


func _ready() -> void:
	if not get_parent().get_class() == "Polygon2D":
		print("ERROR: DestructablePolygonWall parent is not Polygon2D!")
		return

	parent_polygon_2d = get_parent()

	if parent_polygon_2d.get_polygon().is_empty():
		print("ERROR: DestructablePolygonWall parent has no verticies!")
		return
	
	polygon_2d = Polygon2D.new()
	polygon_2d.polygon = parent_polygon_2d.polygon
	add_child(polygon_2d)

	static_body = StaticBody2D.new()
	static_body.set_collision_layer_value(1, true) # Wall
	static_body.set_collision_mask_value(3, true) # Bomb
	static_body.set_collision_mask_value(20, true) # Water
	polygon_2d.add_child(static_body)
	
	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.set_polygon(parent_polygon_2d.get_polygon())
	static_body.add_child(collision_polygon)

	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)


func _on_area_entered():
	print("area entered")
	
func _on_body_entered():
	print("body entered")
