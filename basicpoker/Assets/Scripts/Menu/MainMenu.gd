extends Control

@export var name_input_field: LineEdit
@export var lobby_ip_input_field: LineEdit
@export var invalid_ip_message: String
@export var ip_input_animated_sprite: AnimatedSprite2D


var create_lobby_scene: String = "res://Scenes/MainMenu/creating_lobby.tscn"
var client_scene: String = "res://Scenes/MainMenu/joining_lobby.tscn"
var client_lobby_scene: String = "res://Scenes/MainMenu/joining_lobby.tscn"

func _ready() -> void:
	name_input_field.text = GameManager.player_name

func _on_create_lobby_pressed() -> void:
	update_player_name()
	GameManager.scene_manager.load_gui_scene(create_lobby_scene)

func _on_join_lobby_pressed() -> void:
	update_player_name()
	var ip: String
	var port: int
	var parts = lobby_ip_input_field.text.split(":")
	if parts.size() == 2:
		ip = parts[0]
		port = parts[1] as int
	else:
		invalid_ip()
		return
	
	var client: Client = load(client_scene).instantiate()
	if !client.start_client(ip, port):
		invalid_ip()
		return
		
	GameManager.root_node.add_child(client)
	MultiplayerManager.client = client
	GameManager.scene_manager.load_gui_scene(client_lobby_scene)

func invalid_ip():
	lobby_ip_input_field.text = invalid_ip_message
	ip_input_animated_sprite.play("invalid_ip")

func update_player_name():
	GameManager.update_player_name(name_input_field.text)
