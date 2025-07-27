extends CharacterBody2D

const MAX_SPEED: int = 90
const ACCELERATION: int = 50
const FRICTION: int = 8
const DEFROST_RATE: Vector2 = Vector2(0.1, 0.1)

@onready var shoot_delay: Timer = $ShootDelay
@onready var snow_sound: AudioStreamPlayer2D = $snow_sound
@onready var defrost_timer: Timer = $DefrostTimer

const BULLET = preload("res://scenes/bullet/bullet.tscn")

var can_shoot: bool = true

func _ready() -> void:
	SignalManager.on_player_hit.connect(damage_taken)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	var input = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	var lerp_weight = delta * (ACCELERATION if input else FRICTION)
	velocity = lerp(velocity, input * MAX_SPEED, lerp_weight)
	
	move_and_slide()

func defrosting() -> void:
	scale = scale - DEFROST_RATE
	
	if scale < Vector2(0.5, 0.5):
		die()

func shoot() -> void:
	if can_shoot == true:
		var new_bullet = BULLET.instantiate()

		new_bullet.global_position=global_position
		get_tree().root.add_child(new_bullet)
		shoot_delay.start()
		can_shoot = false
		play_sound()

func play_sound() -> void:
	var pitch = randf_range(0.80, 1.20)
	snow_sound.pitch_scale = pitch
	snow_sound.play()

func die() -> void:
	defrost_timer.stop()
	set_physics_process(false)
	set_process(false)
	SignalManager.on_player_died.emit()

func damage_taken() -> void:
	scale = scale - Vector2(0.5, 0.5)
	
	if scale < Vector2(0.5, 0.5):
		die()

func _on_defrost_timer_timeout() -> void:
	defrosting()

func _on_shoot_delay_timeout() -> void:
	can_shoot = true
