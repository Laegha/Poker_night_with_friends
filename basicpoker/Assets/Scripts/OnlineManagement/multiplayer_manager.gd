extends Node

var host: Host

var udp_socket: PacketPeerUDP
var BRODCAST_PORT: int = 4242

var packet_item_separation = "/:"

func _ready() -> void:
	udp_socket = PacketPeerUDP.new()
	udp_socket.set_broadcast_enabled(true)
	udp_socket.set_dest_address("255.255.255.255", BRODCAST_PORT)
	udp_socket.bind(BRODCAST_PORT)
	
func set_host():
	#rpc_id(1, "get_host", self)
	print("Client trying to get host")
	var error = rpc_id(1, "test_rpc")
	print(str(error) + " While testing rpc")
	print(error)

func get_packet_from_dict(dict: Dictionary) -> String:
	var packet: String = ""
	for key: String in dict:
		packet += str(key) + packet_item_separation + str(dict[key]) + packet_item_separation
	return packet
	
func get_dict_from_packet(packet: String, model_dict: Dictionary):
	var dict: Dictionary = {}
	var keys = model_dict.keys
	var separations_indexes: Array[int] = GameManager.find_all_occurrences(packet, packet_item_separation)
	for key: String in keys:
		var value_start_index: int = packet.find(key) + key.length() + packet_item_separation.length()
		var value_end_index: int
		var larger_separations_indexes: Array[int] = separations_indexes.filter(func(x: int):	x > value_start_index)
		if larger_separations_indexes.is_empty():
			value_end_index = packet.length() -1
		else: 
			value_end_index = larger_separations_indexes.min()
		
		var str_value: String = packet.substr(value_start_index, value_end_index - value_start_index)
		
		dict[key] = str_value
	return dict

@rpc("any_peer", "call_remote", "unreliable")
func test_rpc():
	print("Testing rpc on " + str(multiplayer.get_unique_id()))

@rpc("any_peer")
func get_host(multiplayer_manager: MultiplayerManager):
	print("Called get_host on id: " + str(multiplayer.get_unique_id()))
	multiplayer_manager.host = host
