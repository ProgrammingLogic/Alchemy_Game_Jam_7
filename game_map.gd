extends TileMapLayer
class_name GameMap

@export var cell_size: int = 4

var grid_rect: Rect2i


func _ready() -> void:
	tile_set = load("res://assets/BlowUpTheDam_TileSet.tres")
	_update_grid_bounds()
	_generate_tile_map()



func _update_grid_bounds():
	var win_size = get_window().size
	
	var canvas_tf = get_viewport().get_canvas_transform()
	var screen_to_canvas = canvas_tf.affine_inverse()
	
	var screen_corners: Array[Vector2] = [
		Vector2.ZERO,
		Vector2(win_size.x, 0),
		Vector2(0, win_size.y),
		win_size,
	]
	
	
	var vp_size = get_viewport_rect().size
	var pad = cell_size
	grid_rect = Rect2i(
		Vector2i(-pad / cell_size, -pad / cell_size),
		Vector2i(
			ceil(vp_size.x / float(cell_size)) + pad / cell_size,
			ceil(vp_size.y / float(cell_size)) + pad / cell_size,
		)
	)


func _generate_tile_map():
	var upper_bounds = 5
	#var pipe_position = randi_range(grid_rect.position.x, grid_rect.end.x)
	var pipe_position = Vector2i(
		randi_range(grid_rect.position.x / cell_size, grid_rect.end.x / cell_size),
		1
	)
	set_cell(pipe_position, 1, Vector2i(0, 0))
	var tile_data: TileData = get_cell_tile_data(pipe_position)
	print(tile_data)
	tile_data.flip_v = true
	tile_data.transpose = true
	
	
	for x in range(grid_rect.position.x, grid_rect.end.x):
		for y in range(grid_rect.position.y + upper_bounds, grid_rect.end.y):
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
