extends Control

var main_menu_scene: String = "res://Scenes/MainMenu/mainmenu.tscn"

var available_lobbys: Dictionary

@export var lobby_label_container: BoxContainer
var lobby_label_scene: String = "res://Scenes/MainMenu/lobby_label.tscn"

func _process(delta: float) -> void:
	var packet_count: int = MultiplayerManager.udp_socket.get_available_packet_count()
	if packet_count <= 0:
		print("ERROR RECIEVING PACKET, AVAILABLE PACKETS ARE " + str(packet_count))
		return
	
	print("AVAILABLE PACKETS: " + str(packet_count))
	var recieved_packet: String = MultiplayerManager.udp_socket.get_packet().get_string_from_utf8()
	print("PACKET RECIEVED: " + recieved_packet)
	on_packet_recieved(recieved_packet)

func on_packet_recieved(packet_data: String):
	var data: Dictionary = MultiplayerManager.get_dict_from_packet(packet_data, LobbyData.packet_keys)
	var new_lobby_data: LobbyData = LobbyData.new()
	new_lobby_data.set_packet_data(data)
	var lobby_key: String = new_lobby_data.SERVER_IP + ":" + str(new_lobby_data.SERVER_PORT)
	if lobby_key in available_lobbys:
		available_lobbys[lobby_key].update_lobby_data(new_lobby_data)
	else:
		#instantiate label and give it packet values using MultiplayerManager.get_dict_from_packet
		var new_label: LobbyLabel = load(lobby_label_scene).instantiate()
		lobby_label_container.add_child(new_label)
		available_lobbys[lobby_key] = new_label
		available_lobbys[lobby_key].update_lobby_data(new_lobby_data)
