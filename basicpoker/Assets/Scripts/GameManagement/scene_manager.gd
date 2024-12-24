class_name SceneManager

extends Node

@export var gui: Control
@export var world_2d: Node2D

@export var main_menu_scene: PackedScene

var current_gui_scene: Control
var current_2d_scene: Node2D

func _ready() -> void:
	GameManager.scene_manager = self
	load_gui_scene(main_menu_scene.resource_path)

func load_gui_scene(loaded_scene: String):
	if current_gui_scene != null:
		gui.remove_child(current_gui_scene)
	var new_scene: Control = load(loaded_scene).instantiate()
	print("Just loaded: " + str(main_menu_scene))
	gui.add_child(new_scene)
	current_gui_scene = new_scene
	
func load_2d_scene(loaded_scene: String):
	if current_2d_scene != null:
		world_2d.remove_child(current_2d_scene)
	var new_scene: Node = load(loaded_scene).instantiate()
	world_2d.add_child(new_scene)
	current_2d_scene = new_scene
