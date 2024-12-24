extends Control

var main_menu_scene: String = "res://Scenes/MainMenu/mainmenu.tscn"
var lobby_host_scene: String = "res://Scenes/MainMenu/lobby_host.tscn"

func _on_create_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(lobby_host_scene)


func _on_return_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(main_menu_scene)
