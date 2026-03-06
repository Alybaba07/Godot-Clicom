extends Node2D

func _ready() -> void:
	GameManager.play_menu_music()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/level_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
