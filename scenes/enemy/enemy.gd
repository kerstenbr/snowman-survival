extends CharacterBody2D

var player_inside_vision: bool = false
var player: CharacterBody2D

const SPEED: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()

func _on_shooting_distance_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if player_inside_vision == false:
			player_inside_vision = true

func _on_shooting_distance_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if player_inside_vision == true:
			player_inside_vision = false

func _on_player_reference_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
