class_name BlowUpTheDamGame
extends Minigame



func _ready():
	pass
	# 1. Split hole in half
	# 2. Find where left half of hole is in the original
	# 3. Create a new Polygon
	# 4. Find where the top / bottom of the original Polygon is
	# 5. Add those as the top right / bottom right edges of the original Polygon, splitting it in half
	# 6. Add the left half of the hole's vectors to the new Polygon
	# 7. Do the same thing for the right half
	
	
	
	# Original Polygon Vectors
	# [(347.0, 170.0), (466.0, 345.0), (255.0, 347.0), (205.0, 66.0)]
	#var original = Polygon2D.new()
	#original.set_polygon([
		#Vector2(347.0, 170.0),
		#Vector2(466.0, 345.0),
		#Vector2(255.0, 347.0),
		#Vector2(205.0, 66.0),
	#])
	#original.color = Color(255, 255, 255)
	#add_child(original)
		# 1. Split hole in half
	# 2. Find where left half of hole is in the original
	# 3. Create a new Polygon
	# 4. Find where the top / bottom of the original Polygon is
	# 5. Add those as the top right / bottom right edges of the original Polygon, splitting it in half
	# 6. Add the left half of the hole's vectors to the new Polygon
	# 7. Do the same thing for the right half
	# Hole vectors
	# [(372.0, 213.0), (358.0, 227.0), (344.0, 213.0), (358.0, 199.0)]
	#var hole = Polygon2D.new()
	#hole.set_polygon([
		#Vector2(372.0, 213.0),
		#Vector2(358.0, 227.0),
		#Vector2(344.0, 213.0),
		#Vector2(358.0, 199.0),
	#])
	#hole.color = Color(0, 0, 0)
	#add_child(hole)
	#
	## Get the corners of the original
	#var min_x = 0
	#var min_y = 0
	#var max_x = 0
	#var max_y = 0
#
	#for v: Vector2 in original.get_polygons():
		#if v.x > max_x:
			#max_x = v.x
		#if v.y > max_y:
			#max_y = v.y
		#if v.x < min_x:
			#min_x = v.x
		#if v.y < min_y:
			#min_y = v.y
			#
	#var o_top_left := Vector2(min_x, min_y) # (205.0, 66.0)
	#var o_top_right := Vector2(max_x, min_y) # (466.0, 66.0)
	#var o_bottom_left := Vector2(min_x, max_y) # (205.0, 347.0)
	#var o_bottom_right := Vector2(max_x, max_y) # (466.0, 347.0)
	#
	## Get the "center" of the original
	#var o_center = Vector2(
		#(max_x - min_x) / 2,
		#(max_y - min_y) / 2,
	#)
	#

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
