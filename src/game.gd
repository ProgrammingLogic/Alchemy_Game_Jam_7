extends Node


var TILE_MAP: TileMapLayer = null

enum TILES {
	dirt = 0,
	drain = 1,
	pipe = 2,
	stone_brick_wall = 3,
	wall_one = 4,
	wall_two = 5,
	wall_three = 6,
	wall_four = 7,
}

#
#func _ready() -> void:
	#var water = Water.new()
	#add_child(water)


func _input(event: InputEvent) -> void:
	if event.is_action_released("place_bomb"):
		_place_bomb()	


func _place_bomb() -> void:
	var g_mouse: Vector2 = get_viewport().get_mouse_position()
	var bomb = Bomb.new(g_mouse)
	add_child(bomb)
	bomb.play()


func debug_draw_line(start_point: Vector2, end_point: Vector2, duration := 10.00, color := Color.MAGENTA) -> void:
	var debug_line := Line2D.new()
	debug_line.color = color
	debug_line.add_point(start_point)
	debug_line.add_point(end_point)
	debug_line.z_index = 500
	
	var timer := Timer.new()
	timer.timeout.connect(func():
		debug_line.queue_free()
	)
	
	add_child(debug_line)
	debug_line.add_child(timer)
	timer.start(duration)


func debug_draw_polygon(points: PackedVector2Array, duration := 10.0, color := Color.MAGENTA) -> void:
	var debug_polygon := Polygon2D.new()
	debug_polygon.color = color
	debug_polygon.set_polygon(points)
	debug_polygon.z_index = 500

	var timer = Timer.new()
	timer.timeout.connect(func():
		debug_polygon.queue_free()
	)

	add_child(debug_polygon)
	debug_polygon.add_child(timer)
	timer.start(duration)
