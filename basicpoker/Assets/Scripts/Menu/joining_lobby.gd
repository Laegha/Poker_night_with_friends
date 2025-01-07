extends Control

var main_menu_scene: String = "res://Scenes/MainMenu/mainmenu.tscn"

func _ready() -> void:
	print("PACKET RECIEVED: " + str(MultiplayerManager.udp_socket.get_packet()))
func _on_return_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(main_menu_scene)

func generate_lobby_label(lobby_name: String):
	pass
	
func update_lobby_members(lobby_label: LobbyLabel):
	PacketPeer
	pass
