extends Node3D

class_name BuildingGenerator

@export var room_generator_scene: PackedScene

var room_list: Array[StringName] = ['DiningArea','Kitchen','SupplyCloset','PartsAndService','Office','PirateCove','Bathrooms']
var rooms: Array[Room] = []

enum directions {
	NEGATIVE_Z,
	POSITIVE_Z,
	NEGATIVE_X,
	POSITIVE_X
}

var entry_side: directions
var main_room_dimensions: Vector3i = Vector3i(randi_range(15,25),randi_range(5,8),randi_range(15,25))

func _ready():
	generate()

func generate():
	# temporairily changed
	match randi_range(1,1):
		1:
			entry_side = directions.POSITIVE_Z
		2:
			entry_side = directions.POSITIVE_X
		2:
			entry_side = directions.NEGATIVE_X
	var main_room: RoomGenerator = room_generator_scene.instantiate()
	main_room.dimensions = main_room_dimensions
	main_room.wall_1_door = true
	main_room.wall_3_door = true
	main_room.wall_4_door = true
	add_child(main_room)
	main_room.type = Room.types.DINING_AREA
	rooms.append(main_room)
	
	# UNFINISHED
	var _x_offset = abs(main_room_dimensions.x / 2.0)
	var z_offset = abs(main_room_dimensions.z / 2.0)
	match entry_side:
		directions.POSITIVE_Z:
			var entry_room_dimensions: Vector3i = Vector3i(randi_range(5,8),randi_range(4,7),randi_range(10,15))
			var offset = z_offset + abs(entry_room_dimensions.z / 2.0)
			var entry_room: RoomGenerator = room_generator_scene.instantiate()
			entry_room.dimensions = entry_room_dimensions
			entry_room.wall_2_door = true
			entry_room.wall_4_door = true
			entry_room.position = Vector3(0,0,offset)
			add_child(entry_room)
			entry_room.type = Room.types.ENTRANCE
		directions.POSITIVE_X:
			var _entry_room_dimensions: Vector3i = Vector3i(randi_range(10,15),randi_range(4,7),randi_range(5,8))
		directions.NEGATIVE_X:
			var _entry_room_dimensions: Vector3i = Vector3i(randi_range(10,15),randi_range(4,7),randi_range(5,8))
