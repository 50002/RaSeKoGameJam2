extends Node2D

var Score = 0
@export var boolets: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_score_timeout() -> void:
	Score += 1


func _on_attack_timeout() -> void:
	#makes a six bullet shot
	var shots = boolets.instantiate()
	
	#Location
	var boolets_spawn = $Path2D/boolet_spwnPoints
	boolets_spawn.progress_ratio = randf()
	
	#sets bullet spawn randomly
	shots.position = boolets_spawn.position
	
	add_child(shots)
