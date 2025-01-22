extends Area2D

var Rhood
var manager

func _ready() -> void:
	Rhood = get_parent().get_node("CharacterBody2D")
	manager = get_parent().get_node("CpM")


func _on_body_entered(body: Node2D) -> void:
	print("skill issue")
	if Rhood.Lives == 0:
		get_tree().change_scene_to_file("res://death_screen.tscn")
		
	else:
		Rhood.Lives -= 1
		Rhood.position = manager.last_location
