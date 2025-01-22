extends Control

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()

#changes files after time runs out in timer
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
