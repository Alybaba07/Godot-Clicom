extends Control

func resume():
	get_tree().paused = false
	
func pause():
	get_tree().paused = true
	
func escape():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()
	
		
