extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#ei kääny
	lock_rotation == true
	#liike
	linear_velocity = Vector2(0.0, 150.0).rotated(rotation)*-1.0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
