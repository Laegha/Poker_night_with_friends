extends Control

@export var create_lobby_scene: PackedScene
@export var join_lobby_scene: PackedScene
@export var name_input_field: LineEdit

func _ready() -> void:
	name_input_field.text = GameManager.player_name

func _on_create_lobby_pressed() -> void:
	update_player_name()
	SceneManager.load_scene(create_lobby_scene, $".")

func _on_join_lobby_pressed() -> void:
	update_player_name()
	SceneManager.load_scene(join_lobby_scene, $".")

func update_player_name():
	GameManager.update_player_name(name_input_field.text)
