extends Control

@export var player_labels_container: VBoxContainer
var player_label_scene: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MultiplayerManager.set_packet_peer(true)
	
	MultiplayerManager.host.player_added.connect(add_player_to_list)
	MultiplayerManager.host.player_removed.connect(remove_player_from_list)
	
	brodcast_packet()

func brodcast_packet():
	var packet: String = MultiplayerManager.get_packet_from_dict(MultiplayerManager.host.lobby_data.get_packet_data())
	var buffer_packet: PackedByteArray = packet.to_utf8_buffer()
	var result: Error = MultiplayerManager.udp_socket.put_packet(buffer_packet)
	while result != OK:
		print("Error putting packet " + str(buffer_packet) + ", retrying")
		MultiplayerManager.udp_socket.put_packet(buffer_packet)
		await get_tree().process_frame
	print("Sent packet: " + str(buffer_packet))

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
