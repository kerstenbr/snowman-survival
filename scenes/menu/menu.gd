extends Control

const LEVEL = preload("res://scenes/level/level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL)
