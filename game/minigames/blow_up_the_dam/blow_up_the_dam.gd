class_name BlowUpTheDamGame
extends Minigame


@onready var tile_map: BlowUpTheDamTileMap


func _ready():
	_setup_tile_map()


func _setup_tile_map() -> void:
	tile_map = BlowUpTheDamTileMap.new()
	add_child(tile_map)


func _input(event: InputEvent) -> void:
	if event.is_action_released("place_bomb"):
		_place_bomb()	


func _place_bomb():
	var g_mouse: Vector2 = get_viewport().get_mouse_position()
	var l_mouse: Vector2 = tile_map.to_local(g_mouse)
	var cell: Vector2i = tile_map.local_to_map(l_mouse)
	print("clearing cell (%d, %d)" % [cell.x, cell.y])
	tile_map.erase_cell(cell)
