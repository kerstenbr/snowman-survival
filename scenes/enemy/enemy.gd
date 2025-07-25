extends CharacterBody2D

var player_inside_vision: bool = false
var player: CharacterBody2D
var can_shoot: bool = true

const SPEED: float = 50.0

const ENEMY_BULLET = preload("res://scenes/enemy_bullet/enemy_bullet.tscn")

@onready var shoot_delay: Timer = $ShootDelay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_inside_vision == true:
		shoot()

func _physics_process(delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()

func _on_shooting_distance_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside_vision = true

func _on_shooting_distance_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside_vision = false

func _on_player_reference_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func shoot():
	if can_shoot == true:
		var bullet = ENEMY_BULLET.instantiate()
		bullet.position = global_position
	
		var direction = (player.global_position - global_position).normalized()
		bullet.direction = direction
	
		get_parent().call_deferred("add_child", bullet)
		can_shoot = false
		shoot_delay.start()

func _on_shoot_delay_timeout() -> void:
	can_shoot = true
