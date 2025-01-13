extends Node
@export var test_str: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var result = GameManager.replace_substr_in_str(test_str, MultiplayerManager.packet_item_separation, LobbyData.name_filter)
	print("RESULT " + result)
