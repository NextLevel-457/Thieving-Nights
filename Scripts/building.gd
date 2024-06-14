extends Node3D

class_name BuildingGenerator

@export var room_generator_scene: PackedScene
var marker_scene: PackedScene = preload("res://Scenes/Debug Tools/marker.tscn")

var room_list: Array[StringName] = ['DiningArea','Entrance','Kitchen','SupplyCloset','PartsAndService','Office','PirateCove','Bathrooms']
var rooms: Array[Room] = []

enum directions {
	NEGATIVE_Z,
	POSITIVE_Z,
	NEGATIVE_X,
	POSITIVE_X
}

const wall_dir_correlations = {
	directions.NEGATIVE_Z: 2,
	directions.POSITIVE_Z: 4,
	directions.NEGATIVE_X: 1,
	directions.POSITIVE_X: 3,
}

var entry_side: directions
var main_room_dimensions: Vector3 = Vector3(randi_range(15,25),randi_range(5,8),randi_range(15,25))
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
			var entry_room_dimensions: Vector3 = Vector3(randi_range(8,12),randi_range(4,7),randi_range(12,15))
			var offset = z_offset + abs(entry_room_dimensions.z / 2.0)
			var entry_room: RoomGenerator = room_generator_scene.instantiate()
			entry_room.dimensions = entry_room_dimensions
			entry_room.wall_2_door = true
			entry_room.wall_4_door = true
			entry_room.position = Vector3(0,0,offset)
			add_child(entry_room)
			entry_room.type = Room.types.ENTRANCE
		directions.POSITIVE_X:
			var entry_room_dimensions: Vector3 = Vector3(randi_range(12,15),randi_range(4,7),randi_range(8,12))
			var offset = x_offset + abs(entry_room_dimensions.x / 2.0)
			var entry_room: RoomGenerator = room_generator_scene.instantiate()
			entry_room.dimensions = entry_room_dimensions
			entry_room.wall_1_door = true
			entry_room.wall_3_door = true
			entry_room.position = Vector3(offset,0,0)
			add_child(entry_room)
			entry_room.type = Room.types.ENTRANCE
		directions.NEGATIVE_X:
			var entry_room_dimensions: Vector3 = Vector3(randi_range(12,15),randi_range(4,7),randi_range(8,12))
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
	var open_room_spots: Array[Vector3] = []
	var ors_directions: Array[Vector3] = []
	print("generating hallways\n")
	print("for reference, negative z is ", directions.NEGATIVE_Z)
	print(open_directions)
	for direction in open_directions:
		match direction:
			directions.POSITIVE_Z:
				var hallway_dimensions: Vector3 = Vector3(randi_range(5,8),randi_range(4,5),randi_range(10,15))
				var offset = z_offset + abs(hallway_dimensions.z / 2.0)
				var hallway: RoomGenerator = room_generator_scene.instantiate()
				hallway.dimensions = hallway_dimensions
				hallway.wall_1_door = true
				hallway.wall_2_door = true
				hallway.wall_3_door = true
				hallway.wall_4_door = true
				hallway.position = Vector3(0,0,offset)
				open_room_spots.append(Vector3(
					hallway.position.x + (hallway.dimensions.x / 2),
					hallway.position.y,
					hallway.position.z))
				ors_directions.append(Vector3(1,0,0))
				print("ors directions\n\n\n\n")
				print(ors_directions)
				open_room_spots.append(Vector3(
					hallway.position.x - (hallway.dimensions.x / 2),
					hallway.position.y,
					hallway.position.z))
				ors_directions.append(Vector3(-1,0,0))
				open_room_spots.append(Vector3(
					hallway.position.x,
					hallway.position.y,
					hallway.position.z + (hallway.dimensions.z / 2)))
				ors_directions.append(Vector3(0,0,1))
				print('generating at positive Z with position:')
				print(hallway.position)
				add_child(hallway)
				hallway.type = Room.types.HALLWAY
			directions.POSITIVE_X:
				var hallway_dimensions: Vector3 = Vector3(randi_range(10,15),randi_range(4,5),randi_range(5,8))
				var offset = x_offset + abs(hallway_dimensions.x / 2.0)
				var hallway: RoomGenerator = room_generator_scene.instantiate()
				hallway.dimensions = hallway_dimensions
				hallway.wall_1_door = true
				hallway.wall_2_door = true
				hallway.wall_3_door = true
				hallway.wall_4_door = true
				hallway.position = Vector3(offset,0,0)
				open_room_spots.append(Vector3(
					hallway.position.x,
					hallway.position.y,
					hallway.position.z - (hallway.dimensions.z / 2)))
				ors_directions.append(Vector3(0,0,-1))
				open_room_spots.append(Vector3(
					hallway.position.x + (hallway.dimensions.x / 2),
					hallway.position.y,
					hallway.position.z))
				ors_directions.append(Vector3(1,0,0))
				open_room_spots.append(Vector3(
					hallway.position.x,
					hallway.position.y,
					hallway.position.z + (hallway.dimensions.z / 2)))
				ors_directions.append(Vector3(0,0,1))
				print('generating at positive X with position:')
				print(hallway.position)
				add_child(hallway)
				hallway.type = Room.types.HALLWAY
			directions.NEGATIVE_X:
				var hallway_dimensions: Vector3 = Vector3(randi_range(10,15),randi_range(4,5),randi_range(5,8))
				var offset = x_offset + abs(hallway_dimensions.x / 2.0)
				var hallway: RoomGenerator = room_generator_scene.instantiate()
				hallway.dimensions = hallway_dimensions
				hallway.wall_1_door = true
				hallway.wall_2_door = true
				hallway.wall_3_door = true
				hallway.wall_4_door = true
				hallway.position = Vector3(-offset,0,0)
				open_room_spots.append(Vector3(
					hallway.position.x,
					hallway.position.y,
					hallway.position.z - (hallway.dimensions.z / 2)))
				ors_directions.append(Vector3(0,0,-1))
				open_room_spots.append(Vector3(
					hallway.position.x - (hallway.dimensions.x / 2),
					hallway.position.y,
					hallway.position.z))
				ors_directions.append(Vector3(-1,0,0))
				open_room_spots.append(Vector3(
					hallway.position.x,
					hallway.position.y,
					hallway.position.z + (hallway.dimensions.z / 2)))
				ors_directions.append(Vector3(0,0,1))
				print('generating at negative X with position:')
				print(hallway.position)
				add_child(hallway)
				hallway.type = Room.types.HALLWAY
	for pos in open_room_spots:
		var index = open_room_spots.find(pos)
		var direction: Vector3 = ors_directions[index]
		
		var room: RoomGenerator = room_generator_scene.instantiate()
		var room_dimensions = Vector3(randi_range(5,10),randi_range(7,8),randi_range(5,10))
		room.dimensions = room_dimensions
		var offset = room_dimensions / 2
		offset.y = 0
		offset *= direction
		match direction:
			Vector3(1,0,0):
				room.wall_1_door = true
			Vector3(-1,0,0):
				room.wall_3_door = true
			Vector3(0,0,1):
				room.wall_2_door = true
			Vector3(0,0,-1):
				room.wall_4_door = true
		room.position = pos + offset
		room.position.y = 0
		add_child(room)
