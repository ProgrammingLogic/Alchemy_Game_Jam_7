extends Tile
class_name WallTile


const TILE_SET_IDS: Array[int] = [
	2, # "res://src/scenes/tiles/wall/assets/wall1.png"
	3, # "res://src/scenes/tiles/wall/assets/wall2.png"
	4, # "res://src/scenes/tiles/wall/assets/wall3.png"
	5, # "res://src/scenes/tiles/wall/assets/wall4.png"
]

func _init(wall_variant: int):
	if wall_variant > TILE_SET_IDS.size() - 1:
		print("ERROR: attempting to get invalid WallTile variant (%d)" % wall_variant)

	_init_ids(wall_variant)


func _init_ids(wall_variant: int):
	var primary_id = TILE_SET_IDS.get(wall_variant)
	var new_ids = [primary_id]
	for i in range(0, TILE_SET_IDS.size() - 1):
		if TILE_SET_IDS[i] == primary_id:
			continue

		new_ids.append(TILE_SET_IDS[i])
	
	ids = PackedInt32Array(new_ids)
