extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var snow: TileMapLayer = $Floor/Snow
@onready var enemies: Node2D = $Enemies

const PLAYER_DEATH = preload("res://scenes/player_death/player_death.tscn")
const INCREASE_RATE: Vector2 = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_player_died.connect(game_over)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	remove_snow(delta)

func remove_snow(delta) -> void:
	var snow_tile = snow.local_to_map(player.global_position)
	var source_id = snow.get_cell_source_id(snow_tile)
	if source_id != -1:
		snow.erase_cell(snow_tile)
		increase_player()

func increase_player() -> void:
	player.scale = player.scale + Vector2(0.015, 0.015)

func game_over() -> void:
	get_tree().change_scene_to_packed(PLAYER_DEATH)
