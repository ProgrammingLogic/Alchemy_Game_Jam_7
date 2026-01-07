class_name PolygonWall
extends Polygon2D
## Wall in the shape of a Polygon.
##
## Polygonal shape that acts as a "wall", preventing objects from moving through it.


var DEFAULT_COLLISION_LAYERS: Dictionary = {
	"1": true,
}
var DEFAULT_COLLISION_MASKS: Dictionary = {
	"1": true,
}


@onready var static_body: StaticBody2D
@onready var collision_polygon: CollisionPolygon2D
@onready var collision_layers: Dictionary
@onready var collision_masks: Dictionary

func _init(
		collision_layers: Dictionary = DEFAULT_COLLISION_LAYERS, 
		collision_masks: Dictionary = DEFAULT_COLLISION_MASKS
):
	self.collision_layers = collision_layers
	self.collision_masks = collision_masks


func _ready() -> void:
	if get_polygon().is_empty():
		print("ERROR: Polygon has no verticies!")
		return

	static_body = StaticBody2D.new()
	add_child(static_body)

	collision_polygon = CollisionPolygon2D.new()
	collision_polygon.set_polygon(get_polygon())
	static_body.add_child(collision_polygon)

	for collision_layer in collision_layers.keys():
		static_body.set_collision_layer_value(
			int(collision_layer), 
			collision_layers[collision_layer]
		)