extends Node2D

func _ready() -> void:
	GameManager.play_menu_music()

func _on_lvl_1_pressed() -> void:
	GameManager.stop_music()
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_1.tscn")

func _on_lvl_2_pressed() -> void:
	GameManager.stop_music()
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_2.tscn")

func _on_lvl_3_pressed() -> void:
	GameManager.stop_music()
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_3.tscn")

func _on_lvl_4_pressed() -> void:
	GameManager.stop_music()
	get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_4.tscn")
