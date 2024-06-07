extends Node3D

class_name BuildingGenerator

@export var room_generator_scene: PackedScene

var room_list: Array[StringName] = ['DiningArea','Kitchen','SupplyCloset','PartsAndService','Office','PirateCove','Bathrooms']
var rooms: Array[Room] = []

func _ready():
	generate()

func generate():
	var main_room: RoomGenerator = room_generator_scene.instantiate()
	main_room.dimensions = Vector3(randi_range(15,25),randi_range(5,8),randi_range(15,25))
	add_child(main_room)
	rooms.append(main_room)
	
