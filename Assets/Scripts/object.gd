extends Area2D

func _on_area_entered(area: Area2D) -> void:
	GameManager.play_sfx("res://Assets/Audio/Audio/coin.mp3")
	GameManager.add_object()
	queue_free()
