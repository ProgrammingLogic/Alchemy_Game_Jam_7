extends BaseTile
class_name TileDirt


func _init() -> void:
	name = "dirt"
	texture_path = "res://src/scenes/tiles/dirt/assets/tile_dirt.png"
	destructible = true
	needs_update = false
