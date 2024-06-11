extends Node3D

class_name BuildingGenerator

@export var room_generator_scene: PackedScene

var room_list: Array[StringName] = ['DiningArea','Entrance','Kitchen','SupplyCloset','PartsAndService','Office','PirateCove','Bathrooms']
var rooms: Array[Room] = []

enum directions {
	NEGATIVE_Z,
	POSITIVE_Z,
	NEGATIVE_X,
	POSITIVE_X
}

var entry_side: directions
var main_room_dimensions: Vector3i = Vector3i(randi_range(15,25),randi_range(5,8),randi_range(15,25))
var open_directions: Array[directions] = [directions.POSITIVE_Z,directions.NEGATIVE_X,directions.POSITIVE_X]

func _ready():
	generate()

func generate():
	# Generation of Dining Area.
	var main_room: RoomGenerator = room_generator_scene.instantiate()
	main_room.dimensions = main_room_dimensions
	main_room.wall_1_door = true
	main_room.wall_3_door = true
	main_room.wall_4_door = true
	add_child(main_room)
	main_room.type = Room.types.DINING_AREA
	rooms.append(main_room)
	room_list.erase('DiningArea')
	
	# Generation of Entrance
	match randi_range(1,3):
		1:
			entry_side = directions.POSITIVE_Z
		2:
			entry_side = directions.POSITIVE_X
		3:
			entry_side = directions.NEGATIVE_X
	var x_offset = abs(main_room_dimensions.x / 2.0)
	var z_offset = abs(main_room_dimensions.z / 2.0)
	match entry_side:
		directions.POSITIVE_Z:
			var entry_room_dimensions: Vector3i = Vector3i(randi_range(8,12),randi_range(4,7),randi_range(12,15))
			var offset = z_offset + abs(entry_room_dimensions.z / 2.0)
			var entry_room: RoomGenerator = room_generator_scene.instantiate()
			entry_room.dimensions = entry_room_dimensions
			entry_room.wall_2_door = true
			entry_room.wall_4_door = true
			entry_room.position = Vector3(0,0,offset)
			add_child(entry_room)
			entry_room.type = Room.types.ENTRANCE
		directions.POSITIVE_X:
			var entry_room_dimensions: Vector3i = Vector3i(randi_range(12,15),randi_range(4,7),randi_range(8,12))
			var offset = x_offset + abs(entry_room_dimensions.x / 2.0)
			var entry_room: RoomGenerator = room_generator_scene.instantiate()
			entry_room.dimensions = entry_room_dimensions
			entry_room.wall_1_door = true
			entry_room.wall_3_door = true
			entry_room.position = Vector3(offset,0,0)
			add_child(entry_room)
			entry_room.type = Room.types.ENTRANCE
		directions.NEGATIVE_X:
			var entry_room_dimensions: Vector3i = Vector3i(randi_range(12,15),randi_range(4,7),randi_range(8,12))
			var offset = x_offset + abs(entry_room_dimensions.x / 2.0)
			var entry_room: RoomGenerator = room_generator_scene.instantiate()
			entry_room.dimensions = entry_room_dimensions
			entry_room.wall_1_door = true
			entry_room.wall_3_door = true
			entry_room.position = Vector3(-offset,0,0)
			add_child(entry_room)
			entry_room.type = Room.types.ENTRANCE
	room_list.erase('Entrance')
	open_directions.erase(entry_side)
	
	# Generation of hallways
	print("generating hallways\n")
	print("for reference, negative z is ", directions.NEGATIVE_Z)
	print(open_directions)
	for direction in open_directions:
		match direction:
			directions.POSITIVE_Z:
				var hallway_dimensions: Vector3i = Vector3i(randi_range(5,8),randi_range(4,5),randi_range(10,15))
				var offset = z_offset + abs(hallway_dimensions.z / 2.0)
				var hallway: RoomGenerator = room_generator_scene.instantiate()
				hallway.dimensions = hallway_dimensions
				hallway.wall_1_door = true
				hallway.wall_2_door = true
				hallway.wall_3_door = true
				hallway.wall_4_door = true
				hallway.position = Vector3(0,0,offset)
				print('generating at positive Z with position:')
				print(hallway.position)
				add_child(hallway)
				hallway.type = Room.types.HALLWAY
			directions.POSITIVE_X:
				var hallway_dimensions: Vector3i = Vector3i(randi_range(10,15),randi_range(4,5),randi_range(5,8))
				var offset = x_offset + abs(hallway_dimensions.x / 2.0)
				var hallway: RoomGenerator = room_generator_scene.instantiate()
				hallway.dimensions = hallway_dimensions
				hallway.wall_1_door = true
				hallway.wall_2_door = true
				hallway.wall_3_door = true
				hallway.wall_4_door = true
				hallway.position = Vector3(offset,0,0)
				print('generating at positive X with position:')
				print(hallway.position)
				add_child(hallway)
				hallway.type = Room.types.HALLWAY
			directions.NEGATIVE_X:
				var hallway_dimensions: Vector3i = Vector3i(randi_range(10,15),randi_range(4,5),randi_range(5,8))
				var offset = x_offset + abs(hallway_dimensions.x / 2.0)
				var hallway: RoomGenerator = room_generator_scene.instantiate()
				hallway.dimensions = hallway_dimensions
				hallway.wall_1_door = true
				hallway.wall_2_door = true
				hallway.wall_3_door = true
				hallway.wall_4_door = true
				hallway.position = Vector3(-offset,0,0)
				print('generating at negative X with position:')
				print(hallway.position)
				add_child(hallway)
				hallway.type = Room.types.HALLWAY
