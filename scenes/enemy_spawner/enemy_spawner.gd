extends Node2D

@onready var container = get_node("/root/Level/Enemies")

var enemy_scene: PackedScene = preload("res://scenes/enemy/enemy.tscn")
var spawn_points: Array[Marker2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout() -> void:
	var enemies = 0
	for child in container.get_children():
		if child.is_in_group("Enemy"):
			enemies += 1
	
	var spawn = spawn_points[randi() % spawn_points.size()]
	var enemy = enemy_scene.instantiate()
	
	enemy.global_position = spawn.global_position
	
	if enemies >= 50:
		return
	else:
		container.add_child(enemy)
