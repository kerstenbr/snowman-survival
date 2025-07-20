extends Area2D

var speed: int = 100
var bullet_direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	bullet_direction = (mouse_pos - global_position).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position + bullet_direction * speed * delta

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		queue_free()
		body.queue_free()
