extends Node

var starting_area = 1
var current_area = 1
var area_path = "res://Assets/Scenes/Areas/"

var object = 0
var area_container : Node2D
var player : PlayerController

var music_player : AudioStreamPlayer

func _ready():
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	if area_container == null:
		return
		
	load_area(starting_area)

func next_area():
	current_area += 1
	load_area(current_area)

func load_area(area_number):
	if not is_instance_valid(area_container):
		return

	var full_path = area_path + "area_" + str(area_number) + ".tscn"
	var scene = load(full_path) as PackedScene
	
	if !scene:
		return

	for child in area_container.get_children():
		child.queue_free()
	
	var instance = scene.instantiate()
	area_container.add_child(instance)
	reset_object()
	
func add_object():
	object += 1
	if object >= 3:
		var portal = get_tree().get_first_node_in_group("area_change") as AreaChange
		portal.open()

func reset_object():
	object = 0
	
func play_menu_music():
	if music_player.playing:
		return
		
	var stream = load("res://Assets/Audio/Audio/Menu(shittyjazz).mp3")
	if stream:
		music_player.stream = stream
		music_player.play()
	
func stop_music():
	music_player.stop()
	
func play_sfx(sound_path: String):
	var stream = load(sound_path)
	if stream:
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_player.stream = stream
		
		# Ajoute ces deux lignes pour varier un peu la hauteur du son
		audio_player.pitch_scale = randf_range(0.9, 1.1) 
		
		audio_player.play()
		audio_player.finished.connect(audio_player.queue_free)
	else:
		push_error("Impossible de trouver le fichier son : " + sound_path)
		
