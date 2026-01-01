# When entered by a hitbox, this area will get damaged.
class_name HurtBox
extends Area2D

signal received_damage(damage: int)

@export var health: Health

## Connects the area_entered signal and disables wall collisions.
func _ready():
	connect("area_entered", _on_area_entered)
	set_collision_mask_value(1, false)  # Hurtboxes should not be hurt by walls by default

## Applies damage from the entering HitBox to the Health component.
##
## Args:
##	hitbox: The entering HitBox area.
func _on_area_entered(hitbox: HitBox):
	if hitbox != null:
		health.set_health(health.get_health() - hitbox.get_damage())
		received_damage.emit(hitbox.get_damage())
