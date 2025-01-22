extends CharacterBody2D


var speed = 50
var player_chase = false
var player = null
var health = 5
var state = 0

func _ready() -> void:
	player = get_parent().get_node("CharacterBody2D")
	

#makes it follow the player
func _physics_process(delta: float) -> void:
	if state == 0:
		position += (player.position - position)/speed
		
