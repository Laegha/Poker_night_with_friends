extends Control

@export var name_input_field: LineEdit

var create_lobby_scene: String = "res://Scenes/MainMenu/creating_lobby.tscn"
var join_lobby_scene: String = "res://Scenes/MainMenu/joining_lobby.tscn"

func _ready() -> void:
	name_input_field.text = GameManager.player_name

func _on_create_lobby_pressed() -> void:
	update_player_name()
	GameManager.scene_manager.load_gui_scene(create_lobby_scene)

func _on_join_lobby_pressed() -> void:
	update_player_name()
	GameManager.scene_manager.load_gui_scene(join_lobby_scene)

func update_player_name():
	GameManager.update_player_name(name_input_field.text)
