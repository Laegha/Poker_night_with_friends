extends Control

@export var main_menu_scene: PackedScene
@export var lobby_host_scene: PackedScene

func _ready() -> void:
	print(main_menu_scene)
	print(lobby_host_scene)
	
func _on_create_btn_pressed() -> void:
	get_tree().change_scene_to_packed(lobby_host_scene)


func _on_return_btn_pressed() -> void:
	SceneManager.load_scene(main_menu_scene, $".")
