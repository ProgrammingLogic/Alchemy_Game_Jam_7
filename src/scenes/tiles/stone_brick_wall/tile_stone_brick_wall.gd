extends BaseTile
class_name TileStoneBrickWall


func _init() -> void:
	name = "stone_brick_wall"
	texture_path = "res://src/scenes/tiles/stone_brick_wall/assets/tile_stone_brick_wall.png"
	destructible = false
	needs_update = false
