class_name Client

extends Node

func start_client(SERVER_IP: String, SERVER_PORT: int) -> void:
	multiplayer.connected_to_server.connect(connection_succesful)
	multiplayer.connection_failed.connect(connection_failed)
	
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
		
	multiplayer.multiplayer_peer = client_peer
	multiplayer.multiplayer_peer.peer_connected.connect(peer_connected)
	MultiplayerManager.set_host()
	print("STATUS " + str(multiplayer.multiplayer_peer.get_connection_status()))
	print("Client got host " + str(MultiplayerManager.host))

@rpc
func request_value_change():
	for peer: int in multiplayer.get_peers():
		pass

func peer_connected(id: int):
	print("Player connected!")
	
func connection_succesful():
	print("Client connected")
	
func connection_failed():
	print("Client failed to connect")
