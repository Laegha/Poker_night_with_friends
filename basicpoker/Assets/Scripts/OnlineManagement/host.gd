class_name Host

extends Node

var SERVER_PORT: int = 7777
var SERVER_IP: String = "123"

var lobby_name: String

func _ready() -> void:
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
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
func is_port_available(port: int) -> bool:
	var test_socket: StreamPeerTCP = StreamPeerTCP.new()
	var result: Error = test_socket.listen(port)
	test_socket.close()
	return result == OK
	
func _on_player_connected(id: int):
	pass

func _on_player_disconnected(id: int):
	pass
