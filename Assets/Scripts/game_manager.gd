extends Node

var starting_area = 1
var current_area = 1
var area_path = "res://Assets/Scenes/Areas/"

var object = 0
var area_container : Node2D
var player : PlayerController


func _ready():
	area_container = get_tree().get_first_node_in_group("area_container")
	player = get_tree().get_first_node_in_group("player")
	load_area(starting_area)

func next_area():
	current_area += 1
	load_area(current_area)

func load_area(area_number):
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	#get_tree().change_scene_to_file(full_path)
	var scene = load(full_path) as PackedScene
	if !scene:
		return
	
	# Removing previous scene
	for child in area_container.get_children():
		child.queue_free()
		await child.tree_exited
	
	# Setting up new scene
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
