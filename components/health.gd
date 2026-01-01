class_name Health
extends Node
## Manages an entity's health and immortality state.
##
## Tracks current and maximum health values, provides temporary immortality,
## and emits signals when health changes or is depleted.

signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted

@export var max_health: int = 3 : set = set_max_health, get = get_max_health
@export var immortality: bool = false : set = set_immortality, get = get_immortality

var _immortality_timer: Timer = null

@onready var _health: int = max_health : set = set_health, get = get_health

## Sets the maximum health value.
##
## Ensures the value is at least 1 and adjusts current health if it exceeds the new maximum.
##
## Args:
##     value: The new maximum health value.
func set_max_health(value: int):
	var clamped_value = 1 if value <= 0 else value

	if not clamped_value == max_health:
		var difference = clamped_value - max_health
		max_health = clamped_value
		max_health_changed.emit(difference)

		if _health > max_health:
			_health = max_health

## Returns the maximum health value.
##
## Returns:
##     The current maximum health.
func get_max_health() -> int:
	return max_health

## Sets the immortality state.
##
## Args:
##     value: Whether the entity is immortal.
func set_immortality(value: bool):
	immortality = value

## Activates immortality for a limited time.
##
## Creates or reuses a timer to deactivate immortality after the specified duration.
##
## Args:
##     time: The duration of immortality in seconds.
func set_temporary_immortality(time: float):
	if _immortality_timer == null:
		_immortality_timer = Timer.new()
		_immortality_timer.one_shot = true
		add_child(_immortality_timer)

	if _immortality_timer.timeout.is_connected(set_immortality):
		_immortality_timer.timeout.disconnect(set_immortality)

	_immortality_timer.set_wait_time(time)
	_immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	_immortality_timer.start()

## Returns the immortality state.
##
## Returns:
##     True if the entity is currently immortal.
func get_immortality() -> bool:
	return immortality

## Sets the current health value.
##
## Prevents damage while immortal, clamps the value between 0 and max_health,
## and emits signals for changes or depletion.
##
## Args:
##     value: The new health value.
func set_health(value: int):
	# If we are immortal, we do not want to take any damage, so don't bother changing the health.
	# We aren't skipping changing the health because we want to allow the player to heal while immortal.
	if value < _health and immortality:
		return

	# Clamp the health because we don't want a negative health.
	var clamped_value = clamp(value, 0, max_health)

	# If we already have this value for health, don't bother changing the health / emitting the signal.
	if clamped_value == _health:
		return

	var difference = clamped_value - _health
	_health = clamped_value
	health_changed.emit(difference)

	if _health == 0:
		health_depleted.emit()

## Returns the current health value.
##
## Returns:
##     The current health.
func get_health() -> int:
	return _health
