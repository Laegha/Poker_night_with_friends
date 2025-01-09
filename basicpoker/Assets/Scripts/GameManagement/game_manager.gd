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
	
func find_all_occurrences(input_string: String, key: String) -> Array:
	var occurrences: Array[int] = []
	var start_index: int = 0
	
	while true:
		var index = input_string.find(key, start_index)
		if index == -1:
			break

		occurrences.append(index)
		start_index = index + key.length()

	return occurrences
