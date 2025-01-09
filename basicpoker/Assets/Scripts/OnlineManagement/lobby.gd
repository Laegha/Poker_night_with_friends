class_name Lobby

static var name_filter = "%filtered"

var SERVER_IP: String
var SERVER_PORT: int
var lobby_name: String
var connected_players_ids: Array[int]
var game_mode: String
var initial_chips: int


func get_packet_data() -> Dictionary:
	return{
		"IP" : SERVER_IP,
		"PORT" : SERVER_PORT,
		"LOBBY_NAME" : lobby_name,
		"PLAYERS" : connected_players_ids.size(),
		"GAMEMODE" : game_mode
	}
func set_packet_data(data: Dictionary):
	SERVER_IP = data["IP"]
	SERVER_PORT = data["PORT"]
	lobby_name = data["LOBBY_NAME"]
	connected_players_ids = data["PLAYERS"]
	game_mode = data["GAMEMODE"]

static func unfilter_lobby_name(filtered_lobby_name: String):
	var filters_indexes: Array[int] = GameManager.find_all_occurrences(filtered_lobby_name, name_filter)
	for index: int in filters_indexes:
		var filter_end = index + name_filter.length()
