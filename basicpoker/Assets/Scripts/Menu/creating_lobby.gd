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
	host.lobby.filtered_lobby_name = filter_lobby_name(lobby_name_le.text)
	host.lobby.lobby_name = Lobby.unfilter_lobby_name(host.lobby.filt)
	host.lobby.game_mode = game_modes_btn.text
	host.lobby.initial_chips = int(initial_chips_nle.text)
	await host.start_host()
	MultiplayerManager.host = host
	GameManager.scene_manager.load_gui_scene(lobby_host_scene)
	
func filter_lobby_name(lobby_name: String):
	var filtered_name: String = lobby_name
	
	var separations_in_name: Array[int] = GameManager.find_all_occurrences(lobby_name, MultiplayerManager.packet_item_separation)
	for separation_index: int in separations_in_name:
		filtered_name[separation_index] = Lobby.name_filter
	
	return filtered_name

func _on_return_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(main_menu_scene)
