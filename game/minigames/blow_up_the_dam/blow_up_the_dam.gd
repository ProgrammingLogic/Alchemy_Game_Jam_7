class_name BlowUpTheDamGame
extends Minigame


@onready var tile_map: BlowUpTheDamTileMap


func _ready():
	_setup_tile_map()


func _setup_tile_map() -> void:
	tile_map = BlowUpTheDamTileMap.new(game)
	add_child(tile_map)


func _input(event: InputEvent) -> void:
	if event.is_action_released("place_bomb"):
		_place_bomb()	


func _place_bomb() -> void:
	var g_mouse: Vector2 = get_viewport().get_mouse_position()
	var bomb = Bomb.new(game, tile_map, g_mouse)
	add_child(bomb)
	bomb.play()
