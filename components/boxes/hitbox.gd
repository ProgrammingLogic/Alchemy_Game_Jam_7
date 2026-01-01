class_name HitBox
extends Area2D

## Area that inflicts damage to hurtboxes upon overlap.

@export var _damage: int = 1 : set = set_damage, get = get_damage

## Initializes the hitbox collision settings.
func _ready():
	# Hitboxes do not collide with walls by default.
	set_collision_mask_value(1, false)

## Sets the amount of damage inflicted by the hitbox.
##
## Args:
##     value (int): The new damage value.
func set_damage(value: int):
	_damage = value

## Returns the amount of damage inflicted by the hitbox.
##
## Returns:
##     int: The current damage value.
func get_damage() -> int:
	return _damage
