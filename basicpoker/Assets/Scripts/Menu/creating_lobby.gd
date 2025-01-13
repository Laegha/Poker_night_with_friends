extends Control

var main_menu_scene: String = "res://Scenes/MainMenu/mainmenu.tscn"
var lobby_host_scene: String = "res://Scenes/MainMenu/lobby_host.tscn"

@export var lobby_name_le: LineEdit
@export var game_modes_btn: OptionButton
@export var initial_chips_nle: NumberLineEdit
var host_scene: String = "res://Scenes/Multiplayer/host.tscn"

func _on_create_btn_pressed() -> void:
	var host: Host = load(host_scene).instantiate()
	GameManager.root_node.add_child(host)
	host.lobby_data.filtered_lobby_name = GameManager.replace_substr_in_str(lobby_name_le.text, MultiplayerManager.packet_item_separation, LobbyData.name_filter)
	host.lobby_data.lobby_name = GameManager.replace_substr_in_str(host.lobby_data.filtered_lobby_name, LobbyData.name_filter, MultiplayerManager.packet_item_separation)
	#print("UNFILTERED NAME: " + LobbyData.unfilter_lobby_name(host.lobby_data.filtered_lobby_name))
	host.lobby_data.game_mode = game_modes_btn.text
	host.lobby_data.initial_chips = int(initial_chips_nle.text)
	await host.start_host()
	MultiplayerManager.host = host
	GameManager.scene_manager.load_gui_scene(lobby_host_scene)
	

func _on_return_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(main_menu_scene)
