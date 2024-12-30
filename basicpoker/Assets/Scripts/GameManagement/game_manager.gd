extends Node

var player_name: String
var scene_manager: SceneManager

var root_node: Node

func _ready() -> void:
	for child in get_tree().root.get_children():
		if not child.is_class("AutoLoad"):
			root_node = child

func update_player_name(new_name: String):
	player_name = new_name

func show_full_tree():
	print("Full tree:")
	print(scene_manager.get_tree_string_pretty())
