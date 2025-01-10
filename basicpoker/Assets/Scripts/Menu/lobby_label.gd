extends Control

class_name LobbyLabel

@export var lobby_name_label: Label
@export var connected_people_label: Label
@export var join_button: Button

var lobby_data: LobbyData

func update_lobby_data(new_lobby_data: LobbyData):
	lobby_data = new_lobby_data
	update_gfx()

func update_gfx():
	lobby_name_label.text = lobby_data.lobby_name
	connected_people_label.text = str(lobby_data.connected_players)
	print("Label inscripting data " + lobby_data.lobby_name)
