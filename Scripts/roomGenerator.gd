@tool
extends Node3D

class_name RoomGenerator

@export var dimensions: Vector3 = Vector3(5,5,5)

@export_group("Doors")
@export var wall_1_door: bool = false
@export var wall_2_door: bool = false
@export var wall_3_door: bool = false
@export var wall_4_door: bool = false
@onready var meshes: Array[MeshInstance3D] = [$Wall1Node/Top, $Wall1Node/Side1, $Wall1Node/Side2, $Wall2Node/Top, $Wall2Node/Side1, $Wall2Node/Side2, $Wall3Node/Top, $Wall3Node/Side1, $Wall3Node/Side2, $Wall4Node/Top, $Wall4Node/Side1, $Wall4Node/Side2, $Floor, $Ceiling, $Wall1, $Wall2, $Wall3, $Wall4]

func _ready():
	if Engine.is_editor_hint():
		pass
	else:
		for mesh_instance in meshes:
			mesh_instance.mesh = mesh_instance.mesh.duplicate()
		resize()
		rebuild()
		generate_collisions()
		get_node("Data").set_meta("dimensions",dimensions)
		set_script(preload("res://Classes/Room.gd"))

var last_frame_dimensions: Vector3 = dimensions
var last_frame_doors: Array[bool] = [wall_1_door,wall_2_door,wall_3_door,wall_4_door]

func _process(_delta):
	if Engine.is_editor_hint():
		if dimensions != last_frame_dimensions:
			resize()
			rebuild()
		if last_frame_doors != [wall_1_door,wall_2_door,wall_3_door,wall_4_door]:
			rebuild()
		
		last_frame_doors = [wall_1_door,wall_2_door,wall_3_door,wall_4_door]
		last_frame_dimensions = dimensions

func resize():
	# Resizing floor mesh
	get_node("Floor").mesh.size = dimensions
	get_node("Floor").mesh.size.y = 0.5
	
	# Resizing ceiling mesh
	get_node("Ceiling").mesh.size = dimensions
	get_node("Ceiling").mesh.size.y = 0.5
	# Positioning ceiling mesh
	get_node("Ceiling").position.y = dimensions.y - 0.25
	
	# Resizing wall1 mesh
	get_node("Wall1").mesh.size = dimensions
	get_node("Wall1").mesh.size.x = 0.5
	get_node("Wall1").mesh.size.y = dimensions.y - 1
	# Positioning wall1 mesh
	get_node("Wall1").position.y = dimensions.y / 2
	get_node("Wall1").position.x = -((dimensions.x / 2) - 0.25)
	
	# Resizing wall2 mesh
	get_node("Wall2").mesh.size = dimensions
	get_node("Wall2").mesh.size.z = 0.5
	get_node("Wall2").mesh.size.y = dimensions.y - 1
	get_node("Wall2").mesh.size.x = dimensions.x - 1
	# Positioning wall2 mesh
	get_node("Wall2").position.y = dimensions.y / 2
	get_node("Wall2").position.z = -((dimensions.z / 2) - 0.25)
	
	# Resizing wall3 mesh
	get_node("Wall3").mesh.size = dimensions
	get_node("Wall3").mesh.size.x = 0.5
	get_node("Wall3").mesh.size.y = dimensions.y - 1
	# Positioning wall3 mesh
	get_node("Wall3").position.y = dimensions.y / 2
	get_node("Wall3").position.x = ((dimensions.x / 2) - 0.25)
	
	# Resizing wall4 mesh
	get_node("Wall4").mesh.size = dimensions
	get_node("Wall4").mesh.size.z = 0.5
	get_node("Wall4").mesh.size.y = dimensions.y - 1
	get_node("Wall4").mesh.size.x = dimensions.x - 1
	# Positioning wall4 mesh
	get_node("Wall4").position.y = dimensions.y / 2
	get_node("Wall4").position.z = ((dimensions.z / 2) - 0.25)

func rebuild():
	print("\nRebuilding at:")
	print_stack()
	print("".join(["Dimensions: ",dimensions,"\n"]))
	if wall_1_door:
		print("Building Wall1 door \n")
		# Replacing the base wall mesh with a more complex group of meshes for the door frame
		get_node("Wall1").hide()
		get_node("Wall1Node").show()
		
		# Positioning the frame along the x axis
		print("".join(["Positioning frame along x axis with position ",-((dimensions.x - 0.5) / 2),"\n"]))
		$Wall1Node.position.x = -((dimensions.x - 0.5) / 2)
		
		# Resizing the top of the frame
		print("".join(["Resizing top of frame, size.y: ",str(dimensions.y - 3.5),", size.z: ",str(dimensions.z)," size.x: 0.5"]))
		$Wall1Node/Top.mesh.size.y = dimensions.y - 3.5
		$Wall1Node/Top.mesh.size.z = dimensions.z
		# Positioning the top of the frame
		print("".join(["Positioning top of frame along y axis with position ",(dimensions.y - (($Wall1Node/Top.mesh.size.y / 2)) - 0.5) - 2.5]))
		$Wall1Node/Top.position.y = (dimensions.y - (($Wall1Node/Top.mesh.size.y / 2)) - 0.5) - 2.5
		
		# Resizing the side of the frame
		$Wall1Node/Side1.mesh.size.z = (dimensions.z - 1.5) / 2
		# Positioning the side of the frame
		$Wall1Node/Side1.position.z = ((-dimensions.z - 1.5) / 2) / 2
		
		# Resizing the other side of the frame
		$Wall1Node/Side2.mesh.size.z = (dimensions.z - 1.5) / 2
		# Positioning the other side of the frame
		$Wall1Node/Side2.position.z = ((dimensions.z + 1.5) / 2) / 2
	else:
		get_node("Wall1").show()
		get_node("Wall1Node").hide()
	
	if wall_2_door:
		# Replacing the base wall mesh with a more complex group of meshes for the door frame
		get_node("Wall2").hide()
		get_node("Wall2Node").show()
		
		# Positioning the frame along the z axis
		$Wall2Node.position.z = -((dimensions.z - 0.5) / 2)
		
		# Resizing the top of the frame
		$Wall2Node/Top.mesh.size.y = dimensions.y - 3.5
		$Wall2Node/Top.mesh.size.x = dimensions.x - 1.0
		# Positioning the top of the frame
		$Wall2Node/Top.position.y = (dimensions.y - (($Wall2Node/Top.mesh.size.y / 2)) - 0.5) - 2.5
		
		# Resizing the side of the frame
		$Wall2Node/Side1.mesh.size.x = (dimensions.x - 2.5) / 2
		# Positioning the side of the frame
		$Wall2Node/Side1.position.x = -((((dimensions.x - 1.5) / 2) / 2) + 0.5)
		
		# Resizing the other side of the frame
		$Wall2Node/Side2.mesh.size.x = (dimensions.x - 2.5) / 2
		# Positioning the other side of the frame
		$Wall2Node/Side2.position.x = ((((dimensions.x - 1.5) / 2) / 2) + 0.5)
	else:
		get_node("Wall2").show()
		get_node("Wall2Node").hide()
	
	if wall_3_door:
		# Replacing the base wall mesh with a more complex group of meshes for the door frame
		get_node("Wall3").hide()
		get_node("Wall3Node").show()
		
		# Positioning the frame along the x axis
		$Wall3Node.position.x = ((dimensions.x - 0.5) / 2)
		
		# Resizing the top of the frame
		$Wall3Node/Top.mesh.size.y = dimensions.y - 3.5
		$Wall3Node/Top.mesh.size.z = dimensions.z
		# Positioning the top of the frame
		$Wall3Node/Top.position.y = (dimensions.y - (($Wall3Node/Top.mesh.size.y / 2)) - 0.5) - 2.5
		
		# Resizing the side of the frame
		$Wall3Node/Side1.mesh.size.z = (dimensions.z - 1.5) / 2
		# Positioning the side of the frame
		$Wall3Node/Side1.position.z = ((-dimensions.z - 1.5) / 2) / 2
		
		# Resizing the other side of the frame
		$Wall3Node/Side2.mesh.size.z = (dimensions.z - 1.5) / 2
		# Positioning the other side of the frame
		$Wall3Node/Side2.position.z = ((dimensions.z + 1.5) / 2) / 2
	else:
		get_node("Wall3").show()
		get_node("Wall3Node").hide()
	
	if wall_4_door:
		# Replacing the base wall mesh with a more complex group of meshes for the door frame
		get_node("Wall4").hide()
		get_node("Wall4Node").show()
		
		# Positioning the frame along the z axis
		$Wall4Node.position.z = ((dimensions.z - 0.5) / 2)
		
		# Resizing the top of the frame
		$Wall4Node/Top.mesh.size.y = dimensions.y - 3.5
		$Wall4Node/Top.mesh.size.x = dimensions.x - 1.0
		# Positioning the top of the frame
		$Wall4Node/Top.position.y = (dimensions.y - (($Wall4Node/Top.mesh.size.y / 2)) - 0.5) - 2.5
		
		# Resizing the side of the frame
		$Wall4Node/Side1.mesh.size.x = (dimensions.x - 2.5) / 2
		# Positioning the side of the frame
		$Wall4Node/Side1.position.x = -((((dimensions.x - 1.5) / 2) / 2) + 0.5)
		
		# Resizing the other side of the frame
		$Wall4Node/Side2.mesh.size.x = (dimensions.x - 2.5) / 2
		# Positioning the other side of the frame
		$Wall4Node/Side2.position.x = ((((dimensions.x - 1.5) / 2) / 2) + 0.5)
	else:
		get_node("Wall4").show()
		get_node("Wall4Node").hide()

func generate_collisions():
	if wall_1_door:
		for mesh in get_node("Wall1Node").get_children():
			var collision: CollisionShape3D = CollisionShape3D.new()
			collision.shape = mesh.mesh.create_trimesh_shape()
			collision.position = mesh.position
			get_node("Wall1Node").add_child(collision)
	else:
		var collision: CollisionShape3D = CollisionShape3D.new()
		collision.shape = get_node("Wall1").mesh.create_trimesh_shape()
		collision.position = get_node("Wall1").position
		add_child(collision)
	
	if wall_2_door:
		for mesh in get_node("Wall2Node").get_children():
			var collision: CollisionShape3D = CollisionShape3D.new()
			collision.shape = mesh.mesh.create_trimesh_shape()
			collision.position = mesh.position
			get_node("Wall2Node").add_child(collision)
	else:
		var collision: CollisionShape3D = CollisionShape3D.new()
		collision.shape = get_node("Wall2").mesh.create_trimesh_shape()
		collision.position = get_node("Wall2").position
		add_child(collision)
	
	if wall_3_door:
		for mesh in get_node("Wall3Node").get_children():
			var collision: CollisionShape3D = CollisionShape3D.new()
			collision.shape = mesh.mesh.create_trimesh_shape()
			collision.position = mesh.position
			get_node("Wall3Node").add_child(collision)
	else:
		var collision: CollisionShape3D = CollisionShape3D.new()
		collision.shape = get_node("Wall3").mesh.create_trimesh_shape()
		collision.position = get_node("Wall3").position
		add_child(collision)
	
	if wall_4_door:
		for mesh in get_node("Wall4Node").get_children():
			var collision: CollisionShape3D = CollisionShape3D.new()
			collision.shape = mesh.mesh.create_trimesh_shape()
			collision.position = mesh.position
			get_node("Wall4Node").add_child(collision)
	else:
		var collision: CollisionShape3D = CollisionShape3D.new()
		collision.shape = get_node("Wall4").mesh.create_trimesh_shape()
		collision.position = get_node("Wall4").position
		add_child(collision)
	
	var floor_ceiling_collision: CollisionShape3D = CollisionShape3D.new()
	floor_ceiling_collision.shape = get_node("Floor").mesh.create_trimesh_shape()
	floor_ceiling_collision.position = get_node("Floor").position
	add_child(floor_ceiling_collision)
	floor_ceiling_collision = CollisionShape3D.new()
	floor_ceiling_collision.shape = get_node("Ceiling").mesh.create_trimesh_shape()
	floor_ceiling_collision.position = get_node("Ceiling").position
	add_child(floor_ceiling_collision)
