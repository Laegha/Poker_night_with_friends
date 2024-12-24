extends Node

func connect_to_server(server_ip: String, server_port: int):
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(server_ip, server_port)
