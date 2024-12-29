extends Control

var main_menu_scene: String = "res://Scenes/MainMenu/mainmenu.tscn"
var lobby_host_scene: String = "res://Scenes/MainMenu/lobby_host.tscn"

@export var lobby_name_le: LineEdit
@export var game_modes_btn: OptionButton
@export var initial_chips_nle: NumberLineEdit
var host_scene: String = "res://Scenes/Multiplayer/host.tscn"

func _on_create_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(lobby_host_scene)
	var host: Host = load(host_scene).instantiate()
	host.lobby_name = lobby_name_le.text
	host.game_mode = game_modes_btn.text
	host.initial_chips = int(initial_chips_nle.text)

func _on_return_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(main_menu_scene)
