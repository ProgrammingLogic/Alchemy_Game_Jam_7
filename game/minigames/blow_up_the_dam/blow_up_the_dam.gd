class_name BlowUpTheDamGame
extends Minigame



func _ready():
	pass


func _input(event: InputEvent):
	if event.is_action_released("place_bomb"):
		_place_bomb()	


func _place_bomb():
	var m_pos: Vector2 = get_viewport().get_mouse_position()
	var bomb := Bomb.new(m_pos)
	#bomb.explosion_completed.conn?ect(_on_bomb_exploded)
	add_child(bomb)

func _test_polygon_2d_square_explosion_right_side() -> void:
	pass 
