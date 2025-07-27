extends Area2D

var direction: Vector2 = Vector2.ZERO
var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_player_died.connect(player_died)

func _physics_process(delta):
	position = position + direction * speed * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		SignalManager.on_player_hit.emit()
		queue_free()

func player_died() -> void:
	queue_free()
