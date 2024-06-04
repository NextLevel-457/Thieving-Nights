@tool
extends Node3D

class_name Room

@onready var floor_mesh = $Floor
@onready var ceiling_mesh = $Ceiling
@onready var wall_1_mesh = $Wall1
@onready var wall_2_mesh = $Wall2
@onready var wall_3_mesh = $Wall3
@onready var wall_4_mesh = $Wall4
@onready var wall_1_node = $Wall1Node
@onready var wall_2_node = $Wall2Node

@export var dimensions: Vector3 = Vector3(5,5,5)

@export_group("Doors")
@export var wall_1_door: bool = false
@export var wall_2_door: bool = false
@export var wall_3_door: bool = false
@export var wall_4_door: bool = false

func _ready():
	if Engine.is_editor_hint():
		pass
	else:
		resize()
		rebuild()
		generate_collisions()

var last_frame_dimensions: Vector3 = dimensions
var last_frame_doors: Array[bool] = [wall_1_door,wall_2_door,wall_3_door,wall_4_door]

func _process(delta):
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
	floor_mesh.mesh.size = dimensions
	floor_mesh.mesh.size.y = 0.5
	
	# Resizing ceiling mesh
	ceiling_mesh.mesh.size = dimensions
	ceiling_mesh.mesh.size.y = 0.5
	# Positioning ceiling mesh
	ceiling_mesh.position.y = dimensions.y - 0.25
	
	# Resizing wall1 mesh
	wall_1_mesh.mesh.size = dimensions
	wall_1_mesh.mesh.size.x = 0.5
	wall_1_mesh.mesh.size.y = dimensions.y - 1
	# Positioning wall1 mesh
	wall_1_mesh.position.y = dimensions.y / 2
	wall_1_mesh.position.x = -((dimensions.x / 2) - 0.25)
	
	# Resizing wall2 mesh
	wall_2_mesh.mesh.size = dimensions
	wall_2_mesh.mesh.size.z = 0.5
	wall_2_mesh.mesh.size.y = dimensions.y - 1
	wall_2_mesh.mesh.size.x = dimensions.x - 1
	# Positioning wall2 mesh
	wall_2_mesh.position.y = dimensions.y / 2
	wall_2_mesh.position.z = -((dimensions.z / 2) - 0.25)
	
	# Resizing wall3 mesh
	wall_3_mesh.mesh.size = dimensions
	wall_3_mesh.mesh.size.x = 0.5
	wall_3_mesh.mesh.size.y = dimensions.y - 1
	# Positioning wall3 mesh
	wall_3_mesh.position.y = dimensions.y / 2
	wall_3_mesh.position.x = ((dimensions.x / 2) - 0.25)
	
	# Resizing wall4 mesh
	wall_4_mesh.mesh.size = dimensions
	wall_4_mesh.mesh.size.z = 0.5
	wall_4_mesh.mesh.size.y = dimensions.y - 1
	wall_4_mesh.mesh.size.x = dimensions.x - 1
	# Positioning wall4 mesh
	wall_4_mesh.position.y = dimensions.y / 2
	wall_4_mesh.position.z = ((dimensions.z / 2) - 0.25)

func rebuild():
	if wall_1_door:
		# Replacing the base wall mesh with a more complex group of meshes for the door frame
		wall_1_mesh.hide()
		wall_1_node.show()
		
		# Positioning the frame along the x axis
		$Wall1Node.position.x = -((dimensions.x - 0.5) / 2)
		
		# Resizing the top of the frame
		$Wall1Node/Top.mesh.size.y = dimensions.y - 3.5
		$Wall1Node/Top.mesh.size.z = dimensions.z
		# Positioning the top of the frame
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
		wall_1_mesh.show()
		wall_1_node.hide()
	
	if wall_2_door:
		# Replacing the base wall mesh with a more complex group of meshes for the door frame
		wall_2_mesh.hide()
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
		wall_2_mesh.show()
		get_node("Wall2Node").hide()

func generate_collisions():
	if wall_1_door:
		for mesh in wall_1_node.get_children():
			var collision: CollisionPolygon3D = CollisionPolygon3D.new()
			collision.polygon = mesh.create_trimesh_shape()
			wall_1_node.add_child(collision)
	else:
		var collision: CollisionPolygon3D = CollisionPolygon3D.new()
		collision.polygon = wall_1_mesh.create_trimesh_shape()
		wall_1_mesh.add_child(collision)
