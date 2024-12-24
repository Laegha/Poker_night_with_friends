extends Control

var main_menu_scene: String = "res://Scenes/MainMenu/mainmenu.tscn"

func _ready() -> void:
	print("MainMenu from joiningLobby: " + str(main_menu_scene))

func _on_return_btn_pressed() -> void:
	GameManager.scene_manager.load_gui_scene(main_menu_scene)
