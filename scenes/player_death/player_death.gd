extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_stream_player_2d.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/menu/menu.tscn"))
