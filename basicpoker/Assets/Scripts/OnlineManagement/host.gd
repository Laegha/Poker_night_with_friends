class_name Host

extends Node

var SERVER_PORT: int = 7000
var SERVER_IP: String

var lobby_name: String

var connected_players_ids: Array[int]
var game_mode: String
var initial_chips: int

func start_host() -> void:
	#Getting IP
	if OS.has_feature("windows"):
		if OS.has_environment("COMPUTERNAME"):
			SERVER_IP =  IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)
	elif OS.has_feature("x11"):
		if OS.has_environment("HOSTNAME"):
			SERVER_IP =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	elif OS.has_feature("OSX"):
		if OS.has_environment("HOSTNAME"):
			SERVER_IP =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	
	#Getting an available port
	while not is_port_available(SERVER_PORT):
		SERVER_PORT = randi_range(49152, 65535)
	
	
	var server_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	print("Host succesfully loaded!")
	
func is_port_available(port: int) -> bool:
	var test_socket: TCPServer = TCPServer.new()
	var result: Error = test_socket.listen(port)
	print(result)
	test_socket.stop()
	return result == OK
	
func _on_player_connected(id: int):
	connected_players_ids.append(id)

func _on_player_disconnected(id: int):
	for i in range(0, connected_players_ids.size()):
		if connected_players_ids[i] == id:
			connected_players_ids.remove_at(i)
