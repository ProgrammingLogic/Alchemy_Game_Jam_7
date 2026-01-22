extends TileMapLayer

const GRID_WIDTH := 100
const GRID_HEIGHT := 100


func _ready() -> void:
	Game.TILE_MAP = self
	_generate_map()
	scale_to_screen()
	get_viewport().size_changed.connect(scale_to_screen)
	

func _generate_map() -> void:
	print('generating map')
	randomize()
	var y_offset := GRID_HEIGHT / 10
	
	for y in range(y_offset, GRID_HEIGHT - y_offset):
		for x in range(GRID_WIDTH):
			var pos = Vector2i(x, y)
			var r = randi_range(0, 1)
			
			var tile: int
			if r == 0:
				tile = Game.TILES.dirt
			if r == 1:
				tile = Game.TILES.stone_brick_wall
			
			set_cell(
				pos,
				tile,
				Vector2i.ZERO,
			)


func is_destructible(cell: Vector2i):
	var tile_data = get_cell_tile_data(cell)
	
	if not tile_data:
		return false
	
	return tile_data.get_custom_data("destructible")


func scale_to_screen() -> void:
	var screen_size: Vector2 = get_viewport_rect().size
	var base_map_size: Vector2 = Vector2(GRID_WIDTH * tile_set.tile_size.x, GRID_HEIGHT * tile_set.tile_size.y)
	var scale_factor: float = min(screen_size.x / base_map_size.x, screen_size.y / base_map_size.y)

	# We are getting the minimum of the two so we can preserve the aspect ratio
	scale = Vector2(scale_factor, scale_factor)
	
	#position = (screen_size - base_map_size * scale_factor) / 2


func get_global_position_of_cell(cell: Vector2i) -> Vector2:
	return to_global(cell * tile_set.tile_size)


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
#
#
#func get_cell_tile(cell: Vector2i) -> BaseTile:
	#var id = get_cell_source_id(cell)
	#
	#for tile in TILES:
		#if tile.id == id:
			#return tile
#
	#return TILES[0] # Fallback to the dirt tile
