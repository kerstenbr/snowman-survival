extends CharacterBody2D

const MAX_SPEED: int = 80
const ACCELERATION: int = 50
const FRICTION: int = 8

@onready var snow: TileMapLayer = $"../Floor/Snow"
const BULLET = preload("res://scenes/bullet/bullet.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta: float) -> void:
	var input = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()
	
	var lerp_weight = delta * (ACCELERATION if input else FRICTION)
	velocity = lerp(velocity, input * MAX_SPEED, lerp_weight)
	
	move_and_slide()

func defrosting() -> void:
	scale.x = scale.x - 0.1
	scale.y = scale.y - 0.1
	
	#print(scale)
	
	if scale < Vector2(0.5, 0.5):
		die()

func shoot() -> void:
	var new_bullet = BULLET.instantiate()

	new_bullet.global_position=global_position
	get_tree().root.add_child(new_bullet)

func die() -> void:
	SignalManager.on_player_died.emit()

func _on_timer_timeout() -> void:
	#defrosting()
	pass
