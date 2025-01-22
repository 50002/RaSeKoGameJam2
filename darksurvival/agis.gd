extends CharacterBody2D

var speed = 60
var player_chase = false
var player = null
var health = 5
var state = 0

@onready var hitbox: CollisionShape2D = $attack/CollisionShape2D

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("idle")
	if state == 0:
		if player_chase:
			position.x += (player.position.x - position.x)/speed
			



func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = body
	player_chase = true
