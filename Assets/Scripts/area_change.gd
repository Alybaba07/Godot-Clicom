extends Area2D

class_name AreaChange

@export var sprite : Sprite2D
var is_open = false

func _ready():
	close()

func open():
	is_open = true
	sprite.region_rect.position.x = 22
	
func close():
	is_open = false
	sprite.region_rect.position.x = 0

func _on_body_entered(body: Node2D) -> void:
	print("Collision détectée avec : ", body.name)
	if is_open && body is PlayerController:
		print("Portail ouvert, changement de niveau")
		GameManager.next_area()
		GameManager.play_sfx("res://Assets/Audio/Audio/levelend.wav")
