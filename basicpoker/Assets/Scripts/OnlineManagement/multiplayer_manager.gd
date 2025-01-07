extends Node

var host: Host

func set_host():
	#rpc_id(1, "get_host", self)
	print("Client trying to get host")
	var error = rpc_id(1, "test_rpc")
	print(str(error) + " While testing rpc")
	print(error)

func get_packet(dict: Dictionary) -> String:
	var packet: String = ""
	for key: String in dict:
		packet += str(key) + ":" + str(dict[key]) + ":"
	return packet

@rpc("any_peer", "call_remote", "unreliable")
func test_rpc():
	print("Testing rpc on " + str(multiplayer.get_unique_id()))

@rpc("any_peer")
func get_host(multiplayer_manager: MultiplayerManager):
	print("Called get_host on id: " + str(multiplayer.get_unique_id()))
	multiplayer_manager.host = host
