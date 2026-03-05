extends Control

func resume():
	get_tree().paused = false
	hide()

func pause():
	get_tree().paused = true
	show()

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


func _on_resume_pressed():
	resume()

func _on_menu_pressed():
		get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testEsc()
