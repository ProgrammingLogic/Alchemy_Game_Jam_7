class_name Bomb
extends AnimatedSprite2D


@onready var bomb_animation = preload("res://src/entities/bomb/assets/bomb.tres")

# TODO
# - Scale bomb to screensize
var size = Vector2(32, 32)


func _init(pos: Vector2) -> void:
	position = pos


func _ready() -> void:
	_create_sprite()


func _create_sprite() -> void:
	set_sprite_frames(bomb_animation)
	speed_scale = 2
	animation_finished.connect(_on_animation_finished)


func _on_animation_finished() -> void:
	var explosion_global_rect := Rect2(
		global_position - size / 2,
		size
	)
	
	for cell in MapManager.get_cells_in_rect(explosion_global_rect):
		var tile = MapManager.get_cell_tile(cell)
		if tile.destructible:
			MapManager.erase_cell(cell)

	queue_free()
