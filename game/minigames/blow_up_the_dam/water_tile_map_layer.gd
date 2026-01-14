extends TileMapLayer
class_name WaterTileMapLayer

func _update_water():
	# If wall below:
	#	1. Duplicate
	#	2. Set water_one "direction" to left
	#   3. Set water_two "direction" to right
	#   4. Water moves 1 tile in direction
	#	2. Left water moves 1 tile to left
	# If no wall below:
	#	1. Clear direction
	#	2. Flow down
	pass
