extends Node2D

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
