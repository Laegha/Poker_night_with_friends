class_name LobbyData

static var name_filter: String = "%filtered"
static var packet_keys: Array[String] = ["IP", "PORT", "LOBBY_NAME", "PLAYERS", "GAMEMODE"]

var SERVER_IP: String
var SERVER_PORT: int
var filtered_lobby_name: String
var lobby_name: String
var connected_players: int
var game_mode: String
var initial_chips: int


func get_packet_data() -> Dictionary:
	return{
		"IP" : SERVER_IP,
		"PORT" : SERVER_PORT,
		"LOBBY_NAME" : filtered_lobby_name,
		"PLAYERS" : connected_players,
		"GAMEMODE" : game_mode
	}

func set_packet_data(data: Dictionary):
	SERVER_IP = data["IP"]
	SERVER_PORT = data["PORT"] as int
	filtered_lobby_name = data["LOBBY_NAME"]
	connected_players = data["PLAYERS"] as int
	game_mode = data["GAMEMODE"]
