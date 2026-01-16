extends TileMapLayer
#class_name MapManager

const GRID_WIDTH := 100
const GRID_HEIGHT := 100
const BASE_TILE_SIZE := Vector2i(32, 32)


func _ready() -> void:
	tile_set = load("res://src/services/map_manager/assets/map_manager.tres")
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


func get_global_position_of_cell(cell: Vector2i) -> Vector2:
	return to_global(cell * BASE_TILE_SIZE)


func get_global_rect_of_cell(cell: Vector2i) -> Rect2:
	var center: Vector2 = get_global_position_of_cell(cell)
	var half_size = Vector2(tile_set.tile_size) / 2.0

	return Rect2(
		center - half_size,
		tile_set.tile_size,
	)


func get_cells_in_rect(search_global_rect: Rect2i) -> Array[Vector2i]:
	var result: Array[Vector2i] = []

	var top_left_cell = local_to_map(to_local(search_global_rect.position))
	var bottom_right_cell = local_to_map(to_local(search_global_rect.end))

	for x in range(top_left_cell.x, bottom_right_cell.x + 1):
		for y in range(top_left_cell.y, bottom_right_cell.y + 1):
			var cell = Vector2i(x, y)
			var cell_global_rect = get_global_rect_of_cell(cell)
			
			if search_global_rect.intersects(cell_global_rect):
				result.append(cell)

	return result


func get_cells_in_circle(search_global_circle: CircleShape2D) -> Array[Vector2i]:
	var result: Array[Vector2i] = []

	return result


func get_cells_in_polygon(search_global_polygon: Polygon2D) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	
	return result
