extends Tile
class_name StoneTile


const TILE_SET_IDS: Array[int] = [
	6, 
]


func _init() -> void:
	ids = PackedInt32Array(TILE_SET_IDS)
