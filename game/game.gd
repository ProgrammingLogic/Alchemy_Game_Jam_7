class_name Game
extends Node2D

@onready var current_game: Minigame


func _ready() -> void:
	current_game = BlowUpTheDamGame.new(self)
	add_child(current_game)

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
