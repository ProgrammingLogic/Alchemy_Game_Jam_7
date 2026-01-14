extends TileMapLayer
class_name BlowUpTheDamTileMap

const GRID_WIDTH := 32
const GRID_HEIGHT := 32
const BASE_TILE_SIZE := Vector2(32, 32)


func _ready() -> void:
	tile_set = load("res://assets/tilesets/BlowUpTheDam_TileSet.tres")
	tile_set.tile_size = Vector2i(BASE_TILE_SIZE)
	_generate_map()
	scale_to_screen()
	get_viewport().size_changed.connect(scale_to_screen)


func _generate_map() -> void:
	var dirt := 0
	var pipe := 1
	
	var y_offset := GRID_HEIGHT / 10
	
	# Fill the map with dirt
	for y in range(5, GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			set_cell(Vector2i(x, y), dirt, Vector2i(0, 0))


func scale_to_screen() -> void:
	var screen_size: Vector2 = get_viewport_rect().size
	var base_map_size: Vector2 = Vector2(GRID_WIDTH * BASE_TILE_SIZE.x, GRID_HEIGHT * BASE_TILE_SIZE.y)
	var scale_factor: float = min(screen_size.x / base_map_size.x, screen_size.y / base_map_size.y)

	# We are getting the minimum of the two so we can preserve the aspect ratio
	scale = Vector2(scale_factor, scale_factor)
	
	position = (screen_size - base_map_size * scale_factor) / 2
