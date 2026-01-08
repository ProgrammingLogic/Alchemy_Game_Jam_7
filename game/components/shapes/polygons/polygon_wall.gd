class_name PolygonWall
extends StaticBody2D
## Wall in the shape of a Polygon.
##
## Polygonal shape that acts as a "wall", preventing objects from moving through it.


var DEFAULT_COLLISION_LAYERS: Dictionary = {
	"1": true,
}
var DEFAULT_COLLISION_MASKS: Dictionary = {
	"1": true,
}


@onready var parent_polygon_2d: Polygon2D
@onready var collision_polygon: CollisionPolygon2D
@onready var collision_layers: Dictionary
@onready var collision_masks: Dictionary


func _init(
		collision_layers: Dictionary = DEFAULT_COLLISION_LAYERS, 
		collision_masks: Dictionary = DEFAULT_COLLISION_MASKS
):
	for collision_layer in collision_layers.keys():
		set_collision_layer_value(
			int(collision_layer), 
			collision_layers[collision_layer]
		)

	for collision_mask in collision_masks.keys():
		set_collision_mask_value(
			int(collision_mask), 
			collision_layers[collision_mask]
		)


func _ready() -> void:
	if not get_parent().get_class() == "Polygon2D":
		print("ERROR: PolygonWall parent is not Polygon2D!")
		return

	parent_polygon_2d = get_parent()

	if parent_polygon_2d.get_polygon().is_empty():
		print("ERROR: Polygon has no verticies!")
		return

	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.set_polygon(parent_polygon_2d.get_polygon())
	add_child(collision_polygon)
