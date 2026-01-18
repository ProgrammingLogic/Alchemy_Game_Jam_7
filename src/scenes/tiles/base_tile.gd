class_name BaseTile
extends RefCounted


var name: String = ""
var id: int
var texture_path: String = ""
var destructible: bool = false
var needs_update: bool = false
var physics_layers: Array[int] = [
	1,
]


func register(tile_set: TileSet) -> void:
	var source = TileSetAtlasSource.new()
	source.texture = load(texture_path)
	source.texture_region_size = tile_set.tile_size
	source.use_texture_padding = true
	
	# We are assuming the tile texture is a single tile_size BY tile_size
	#     image, and does not contain multiple tiles per image.
	source.create_tile(Vector2i(0, 0))
	id = tile_set.add_source(source)
	
	var tile_data: TileData = source.get_tile_data(Vector2i(0, 0), 0)

	# Physics polygon is top left, top right, bottom right, bottom left corner
	#	because I don't care.
	
	tile_data.add_collision_polygon(0)
	for layer in physics_layers:
		tile_data.set_collision_polygon_points(
			layer, 
			0, 
			PackedVector2Array([
				Vector2(0,0),
				Vector2(tile_set.tile_size.x,0), 
				Vector2(tile_set.tile_size.x, tile_set.tile_size.y), 
				Vector2(0, tile_set.tile_size.y)
			]
		))
	
	
