extends AnimatedSprite2D

@export var water_spawn_point: Node2D
@onready var _water_created := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	if not _water_created:
		create_water()
		


func create_water():
	var _new_water_particle: WaterParticle = WaterParticle.new()
	var _parent_scene = get_tree().get_root()
	_parent_scene.add_child(_new_water_particle)
	_new_water_particle.position = water_spawn_point.global_position
	_water_created = true
