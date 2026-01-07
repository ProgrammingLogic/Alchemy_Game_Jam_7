class_name Game
extends Node

@onready var current_game: Minigame


func _ready() -> void:
	current_game = BlowUpTheDamGame.new(self)
