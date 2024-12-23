extends Node

@export var gui: Control
@export var world_2d: Node2D

@export var main_menu_scene: PackedScene

var current_gui_scene: Control
var current_2d_scene: Node2D

func _ready() -> void:
	if main_menu_scene != null:
		load_gui_scene(main_menu_scene)

func load_gui_scene(loaded_scene: PackedScene):
	if current_gui_scene != null:
		gui.remove_child(current_gui_scene)
	var new_scene: Control = (loaded_scene.instantiate())
	gui.add_child(new_scene)
	current_gui_scene = new_scene
	
func load_2d_scene(loaded_scene: PackedScene):
	if current_2d_scene != null:
		world_2d.remove_child(current_2d_scene)
	var new_scene: Node = (loaded_scene.instantiate())
	world_2d.add_child(new_scene)
	current_2d_scene = new_scene
