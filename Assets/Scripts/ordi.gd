extends Area2D

class_name OrdiEnd

@export var sprite : Sprite2D
var is_repaired = false

func _ready():
	set_broken()

func open():
	is_repaired = true
	sprite.region_rect.position.x = 163.5
	print("L'ordinateur est maintenant prêt à être utilisé !")

func set_broken():
	is_repaired = false
	if sprite:
		sprite.region_rect.position.x = 255.5

func _on_body_entered(body: Node2D) -> void:
	if is_repaired && body is PlayerController:
		print("Ordinateur réparé ! Fin du niveau.")
		# On déclenche la suite (changement de zone ou écran de victoire)
		GameManager.next_area()
