extends CharacterBody2D

var speed = 10
var player_chase = false
var player = null
var health = 5
var state = 0

func _ready() -> void:
	player = get_parent().get_node("CharacterBody2D")
	

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("idle")
	if state == 0:
		position += (player.position - position)/speed
			


func _on_attack_timeout() -> void:
	$CollisionShape2D/FanAttack/bullet.rotate(player.position)
