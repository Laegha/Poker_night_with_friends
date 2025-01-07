extends Control

@export var player_labels_container: VBoxContainer
var player_label_scene: String = ""
var BRODCAST_PORT: int = 4242

func get_packet_data() -> Dictionary:
	return{
		"IP" : MultiplayerManager.host.SERVER_IP,
		"PORT" : MultiplayerManager.host.SERVER_PORT,
		"PLAYERS" : MultiplayerManager.host.connected_players_ids.size(),
		"GAMEMODE" : MultiplayerManager.host.game_mode,
	}

var udp_socket: PacketPeerUDP
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#MultiplayerManager.host.
	udp_socket = PacketPeerUDP.new()
	udp_socket.set_broadcast_enabled(true)
	
	MultiplayerManager.host.player_added.connect(add_player_to_list)
	MultiplayerManager.host.player_removed.connect(remove_player_from_list)
	
	udp_socket.set_dest_address("255.255.255.255", BRODCAST_PORT)
	brodcast_packet()

func brodcast_packet():
	var packet: String = MultiplayerManager.get_packet(get_packet_data())
	udp_socket.put_packet(packet.to_utf8_buffer())

func add_player_to_list(id: int):
	print("Host detected the join of " + str(id))
	brodcast_packet()
	#var player_label: Control = load(player_label_scene).instantiate()
	#var name_label: Label = GameManager.get_child_in_node(player_label, "NameLabel") as Label
	
	#MultiplayerManager.host
	#player_labels_container.add_child()
	pass
	
func remove_player_from_list():
	brodcast_packet()
