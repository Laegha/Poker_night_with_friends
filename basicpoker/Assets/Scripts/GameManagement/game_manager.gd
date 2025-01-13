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

func replace_substr_in_str(original_string: String, substr_to_replace: String, substr_to_put: String):
	var replaceable_indexes: Array[int] = GameManager.find_all_occurrences(original_string, substr_to_replace)
	if replaceable_indexes.is_empty():
		return original_string
	
	replaceable_indexes.sort()
	var last_repleacable_end: int = 0
	var kept_parts: Array[String] = []
	for repleaceable_start: int in replaceable_indexes:
		kept_parts.append(original_string.substr(last_repleacable_end, repleaceable_start))
		last_repleacable_end = repleaceable_start + substr_to_replace.length()
	
	if last_repleacable_end < original_string.length():
		kept_parts.append(original_string.substr(last_repleacable_end, original_string.length()))
	
	var repleaced_name: String = ""
	for kept_part: String in kept_parts:
		repleaced_name += kept_part + MultiplayerManager.packet_item_separation
	return repleaced_name
