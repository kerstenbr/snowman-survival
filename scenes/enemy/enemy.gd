extends CharacterBody2D

var player_inside_vision: bool = false
var player: CharacterBody2D
var can_shoot: bool = true

const SPEED: float = 50.0

const ENEMY_BULLET = preload("res://scenes/enemy_bullet/enemy_bullet.tscn")

@onready var shoot_delay: Timer = $ShootDelay
@onready var fireball_sound: AudioStreamPlayer2D = $fireball_sound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	SignalManager.on_player_died.connect(player_died)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_inside_vision == true and can_shoot == true:
		velocity = Vector2(0, 0)
		shoot()

func _physics_process(delta: float) -> void:
	if player:
		if player_inside_vision == false:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * SPEED
			move_and_slide()
		else:
			velocity = Vector2(0, 0)

func _on_shooting_distance_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside_vision = true

func _on_shooting_distance_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside_vision = false

func shoot():
	var bullet = ENEMY_BULLET.instantiate()
	bullet.position = global_position
	
	var direction = global_position.direction_to(player.global_position)
	bullet.direction = direction
	
	
	get_parent().call_deferred("add_child", bullet)
	can_shoot = false
	shoot_delay.start()
	play_sound()

func _on_shoot_delay_timeout() -> void:
	can_shoot = true

func player_died() -> void:
	set_physics_process(false)
	set_process(false)

func play_sound() -> void:
	var pitch = randf_range(0.80, 1.20)
	fireball_sound.pitch_scale = pitch
	
	fireball_sound.play()
