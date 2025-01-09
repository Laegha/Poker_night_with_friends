extends Control

@export var player_labels_container: VBoxContainer
var player_label_scene: String = ""
var BRODCAST_PORT: int = 4242

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MultiplayerManager.host.player_added.connect(add_player_to_list)
	MultiplayerManager.host.player_removed.connect(remove_player_from_list)
	
	brodcast_packet()

func brodcast_packet():
	var packet: String = MultiplayerManager.get_packet_from_dict(MultiplayerManager.host.lobby.get_packet_data())
	var buffer_packet: PackedByteArray = packet.to_utf8_buffer()
	var error = MultiplayerManager.udp_socket.put_packet(buffer_packet)
	print("Available packets" + str(MultiplayerManager.udp_socket.get_available_packet_count()))
	print("Sent packet2" + str(buffer_packet))

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
