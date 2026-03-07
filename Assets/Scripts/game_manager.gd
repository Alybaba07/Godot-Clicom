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
	var full_path = area_path + "area_" + str(area_number) + ".tscn"
	
	if not FileAccess.file_exists(full_path):
		print("Erreur : Le fichier n'existe pas -> ", full_path)
		return

	get_tree().change_scene_to_file(full_path)
	reset_object()
	current_area = area_number
	
func add_object():
	await get_tree().process_frame
	
	var remaining_objects = get_tree().get_nodes_in_group("object")
	
	print("Objets restants : ", remaining_objects.size())
	
	if remaining_objects.size() == 0:
		var portal = get_tree().get_first_node_in_group("area_change") as AreaChange
		if portal:
			portal.open()
		else:
			push_error("Portail non trouvé ! Vérifie qu'il est dans le groupe 'area_change'")

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
		
