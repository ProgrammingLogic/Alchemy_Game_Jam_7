extends AnimatedSprite2D
## Pipe that spawns water into the game.
##
## Initializes a timer with a 0.1 second delay and then connects the 
## [method Node._create_water] to it's timeout signal. create_water will then
## spawn a WaterParicle at $WaterSpawnPoint.

@export var is_spawning_water = true

@onready var water_spawn_timer: Timer = Timer.new()
@onready var water_spawn_point: Node2D = $WaterSpawnPoint


func _ready() -> void:	
	water_spawn_timer.wait_time = 0.1
	water_spawn_timer.autostart = true
	
	add_child(water_spawn_timer)
	
	water_spawn_timer.start()
	water_spawn_timer.timeout.connect(create_water)


## Adds a water particle into the world.
##
## Creates a new WaterParticle object, with it's initial position equal to the
## water_spawn_point's poistion. It then adds the WaterParticle to the root 
## scene.
func create_water() -> void:
	if not is_spawning_water:
		return
		
	var water_particle = WaterParticle.new()
	var parent_scene: Node = get_tree().get_root()
	
	parent_scene.add_child(water_particle)
	
	water_particle.position = water_spawn_point.global_position
