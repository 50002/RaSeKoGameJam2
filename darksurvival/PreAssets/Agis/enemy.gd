extends CharacterBody2D

var speed = 60
var player_chase = false
var player = null
var attack = false
var health = 5
var state = 0
@onready var hitbox: CollisionShape2D = $attack/CollisionShape2D

@onready var timer = $Timer
@onready var hit_state = $hit_state
@onready var death = $death

func _physics_process(delta: float) -> void:
	if state == 0:
		if player_chase:

			position.x += (player.position.x - position.x)/speed
			$AnimatedSprite2D.play("move")
		
			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			
		elif attack == true:
			if $AnimatedSprite2D.get_frame() in [6, 7, 8, 9, 10]:
				hitbox.disabled = false
			else:
				hitbox.disabled = true
			
		else:
			$AnimatedSprite2D.play("move")
	else:
		pass
	
func _on_detector_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = body
	player_chase = true


func _on_detector_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = null
	player_chase = false


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	player = body
	player_chase = false
	attack = true
	
	$AnimatedSprite2D.play("bomb")
	timer.start()

func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass
	
func _on_timer_timeout() -> void:
	player_chase = true
	attack = false
	hitbox.disabled = true


func _on_hitbox_area_entered(area: Area2D) -> void:
	state = 1
	health -= 1
	if health <= 0:
		queue_free()

	else:
		$AnimatedSprite2D.play("hort")
		hit_state.start()


func _on_hit_state_timeout() -> void:
	state = 0
