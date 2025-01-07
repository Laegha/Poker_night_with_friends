class_name Host

extends Node

var SERVER_PORT: int = 55000
var SERVER_IP: String

var lobby_name: String

var connected_players_ids: Array[int]
var game_mode: String
var initial_chips: int

signal player_added
signal player_removed

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
	
	var server_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	#Getting an available port
	while server_peer.create_server(SERVER_PORT) != OK:
		SERVER_PORT = randi_range(49152, 65535)
	
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
	print("Host succesfully loaded with ID: " + str(multiplayer.get_unique_id()) + " on port: " + str(SERVER_PORT))
	
func is_port_available(port: int) -> bool:
	var test_socket: TCPServer = TCPServer.new()
	var result: Error = test_socket.listen(port)
	test_socket.stop()
	return result == OK
	
func _on_player_connected(id: int):
	connected_players_ids.append(id)
	on_player_added.emit()

func _on_player_disconnected(id: int):
	for i in range(0, connected_players_ids.size()):
		if connected_players_ids[i] == id:
			connected_players_ids.remove_at(i)
	on_player_removed.emit()
