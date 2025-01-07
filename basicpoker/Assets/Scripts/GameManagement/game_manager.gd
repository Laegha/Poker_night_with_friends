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

func get_child_in_node(node: Node, child_name: String):
	for child in node.get_children():
		if child.name == child_name:
			return child
	return null
