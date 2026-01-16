extends Node
class_name Tile


# The ID this tile is associated with in "res://src/services/map_manager/assets/map_manager.tres"
#
# ID 0 is the main ID of the tile
var ids: PackedInt32Array:
	get:
		return ids
	set(value):
		ids = value


var destructable: bool = false


func _ready():
	if not ids:
		print("ERROR: Tile has no IDs")
		return


func update():
	pass
