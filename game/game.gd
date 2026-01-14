class_name Game
extends Node2D

@onready var current_game: Minigame


func _ready() -> void:
	current_game = BlowUpTheDamGame.new(self)
	add_child(current_game)
