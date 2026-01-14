extends TileMapLayer
class_name WaterSimulation

@export var cell_size: int = 4

var grid_rect: Rect2i


func _ready() -> void:
	use_kinematic_bodies = true
	update_grid_bounds()
	tile_set = tile_set


func update_grid_bounds():
	var vp_size = get_viewport_rect().size
	var pad = cell_size * 2
	grid_rect = Rect2i(
		Vector2i(-pad / cell_size, -pad / cell_size),
		Vector2i(
			ceil(vp_size.x / float(cell_size)) + pad / cell_size * 2,
			ceil(vp_size.y / float(cell_size)) + pad / cell_size * 2,
		)
	)
