extends Node2D
class_name Water


const LINE_WIDTH = 8

var water_lines: Array[WaterLine] = []
var split_points: PackedVector2Array = []
var update_timer := Timer.new()


func _ready() -> void:
	update_timer.timeout.connect(update)
	add_child(update_timer)
	update_timer.start(1)


func update() -> void:
	clear_water()
	water_lines.append(WaterLine.new(self, [position]))


func clear_water() -> void:
	for water_line in water_lines:
		water_line.queue_free()
	
	water_lines = []
