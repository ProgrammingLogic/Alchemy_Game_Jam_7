extends Node

@onready var current_scene
@onready var root: Node = get_tree().root

func _ready():
	current_scene = root.get_child(-1)


func goto_scene(path: String) -> void:
	# Wait until the end of the current frame to switch scenes, because
	#	otherwise, deloading data in the middle of a scene could cause
	#	unexpected behavior.
	_goto_scene_deferred.call_deferred(path)


func _goto_scene_deferred(path: String) -> void:
	current_scene.free()

	var scene = ResourceLoader.load(path)
	current_scene = scene.instantiate()
	
	root.add_child(current_scene)

	# Make it compatible with SceneTree.change_scene_to_file()
	get_tree().current_scene = current_scene  
