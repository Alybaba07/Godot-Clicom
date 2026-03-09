extends Node

var starting_area = 1
var current_area = 1
var area_path = "res://Assets/Scenes/Areas/"

var object = 0
var area_container : Node2D
var player : PlayerController
var music_player : AudioStreamPlayer
#var hud : HUD

func _ready():
	#Pour HUD
	#hud = get_tree().get_first_node_in_group("hud")
	
	if music_player == null:
		music_player = AudioStreamPlayer.new()
		add_child(music_player)
		music_player.process_mode = Node.PROCESS_MODE_ALWAYS
	
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	if area_container != null:
		load_area(starting_area)

func next_area():
	current_area += 1
	load_area.call_deferred(current_area)

func load_area(area_number):
	var full_path = area_path + "area_" + str(area_number) + ".tscn"
	var scene_resource = load(full_path)
	
	if scene_resource:
		get_tree().change_scene_to_packed(scene_resource)
		reset_object()
		current_area = area_number
		print("Chargement du niveau : ", area_number)
	else:
		print("Plus de niveaux trouvés. Direction l'écran de fin !")
		var win_scene = load("res://Assets/Scenes/win_screen.tscn")
		if win_scene:
			get_tree().change_scene_to_packed(win_scene)
		else:
			push_error("Erreur critique : Impossible de trouver win_screen.tscn")
	
func add_object():
	await get_tree().process_frame
	var remaining_objects = get_tree().get_nodes_in_group("object")
	
	if remaining_objects.size() == 0:
		var portal = get_tree().get_first_node_in_group("area_change")
		
		if portal and portal.has_method("open"):
			portal.open()
		else:
			push_error("Portail/Ordi non trouvé ou fonction open() manquante !")

func reset_object():
	object = 0
	
func play_menu_music():
	_play_music("res://Assets/Audio/Audio/Menu(shittyjazz).mp3")

func play_level_music():
	_play_music("res://Assets/Audio/Audio/level.mp3")

# Fonction interne pour éviter les coupures
func _play_music(track_path: String):
	# Si la musique joue déjà la BONNE piste, on ne touche à rien (pas de coupure)
	if music_player.playing and music_player.stream and music_player.stream.resource_path == track_path:
		return
		
	var stream = load(track_path)
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
		audio_player.pitch_scale = randf_range(0.9, 1.1) 
		audio_player.play()
		audio_player.finished.connect(audio_player.queue_free)
	else:
		push_error("Impossible de trouver le fichier son : " + sound_path)
		
