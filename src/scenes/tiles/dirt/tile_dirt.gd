extends Tile
class_name TileDirt


const TILE_SET_IDS: Array[int] = [
	0, # "res://src/scenes/tiles/dirt/assets/tile_dirt.png"
]

func _init():
	ids = PackedInt32Array(TILE_SET_IDS)
	destructable = true
