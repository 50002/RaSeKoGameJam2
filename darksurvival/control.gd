extends Control





func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://start_screen.tscn")


func _on_again_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
