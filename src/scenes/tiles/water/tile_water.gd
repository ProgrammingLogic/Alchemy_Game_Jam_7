extends BaseTile
class_name TileWater


func _init() -> void:
	name = "water"
	texture_path = "res://src/scenes/tiles/water/assets/Drop.png"
	destructible = false
	needs_update = true


func update() -> void:
	pass
