extends Node3D

class_name Room

enum types {
	DINING_AREA,
	KITCHEN,
	SUPPLY_CLOSET,
	PARTS_AND_SERVICE,
	OFFICE,
	PIRATE_COVE,
	BATHROOMS,
	ENTRANCE,
	HALLWAY,
}

var type: types
var dimensions: Vector3
var prop_spots: Dictionary = {}
var marker_scene = preload("res://Scenes/Debug Tools/marker.tscn")

func _init():
	dimensions = get_node("Data").get_meta("dimensions")
	# Bottom positions
	prop_spots["Bottom"] = Vector3(0,0.5,0)
	prop_spots["Bottom_North"] = Vector3(0,0.5,(-dimensions.z / 2) + 0.5)
	prop_spots["Bottom_South"] = Vector3(0,0.5,(dimensions.z / 2) - 0.5)
	prop_spots["Bottom_East"] = Vector3((-dimensions.x / 2) + 0.5,0.5,0)
	prop_spots["Bottom_West"] = Vector3((dimensions.x / 2) - 0.5 / 2,0.5,0)
	prop_spots["Bottom_Northeast"] = Vector3((-dimensions.x / 2) + 0.5,0.5,(-dimensions.z / 2) + 0.5)
	prop_spots["Bottom_Southeast"] = Vector3((-dimensions.x / 2) + 0.5,0.5,(dimensions.z / 2) - 0.5)
	prop_spots["Bottom_Southwest"] = Vector3((dimensions.x / 2) - 0.5,0.5,(dimensions.z / 2) - 0.5)
	prop_spots["Bottom_Northwest"] = Vector3((dimensions.x / 2) - 0.5,0.5,(-dimensions.z / 2) + 0.5)
	# Middle positions
	prop_spots["Center"] = Vector3(0,dimensions.y / 2,0)
	prop_spots["Center_North"] = Vector3(0,dimensions.y / 2,(-dimensions.z / 2) + 0.5)
	prop_spots["Center_South"] = Vector3(0,dimensions.y / 2,(dimensions.z / 2) - 0.5)
	prop_spots["Center_East"] = Vector3((-dimensions.x / 2) + 0.5,dimensions.y / 2,0)
	prop_spots["Center_West"] = Vector3((dimensions.x / 2) - 0.5 / 2,dimensions.y / 2,0)
	prop_spots["Center_Northeast"] = Vector3((-dimensions.x / 2) + 0.5,dimensions.y / 2,(-dimensions.z / 2) + 0.5)
	prop_spots["Center_Southeast"] = Vector3((-dimensions.x / 2) + 0.5,dimensions.y / 2,(dimensions.z / 2) - 0.5)
	prop_spots["Center_Southwest"] = Vector3((dimensions.x / 2) - 0.5,dimensions.y / 2,(dimensions.z / 2) - 0.5)
	prop_spots["Center_Northwest"] = Vector3((dimensions.x / 2) - 0.5,dimensions.y / 2,(-dimensions.z / 2) + 0.5)
	# Top positions
	prop_spots["Top"] = Vector3(0,dimensions.y - 0.5,0)
	prop_spots["Top_North"] = Vector3(0,dimensions.y - 0.5,(-dimensions.z / 2) + 0.5)
	prop_spots["Top_South"] = Vector3(0,dimensions.y - 0.5,(dimensions.z / 2) - 0.5)
	prop_spots["Top_East"] = Vector3((-dimensions.x / 2) + 0.5,dimensions.y - 0.5,0)
	prop_spots["Top_West"] = Vector3((dimensions.x / 2) - 0.5 / 2,dimensions.y - 0.5,0)
	prop_spots["Top_Northeast"] = Vector3((-dimensions.x / 2) + 0.5,dimensions.y - 0.5,(-dimensions.z / 2) + 0.5)
	prop_spots["Top_Southeast"] = Vector3((-dimensions.x / 2) + 0.5,dimensions.y - 0.5,(dimensions.z / 2) - 0.5)
	prop_spots["Top_Southwest"] = Vector3((dimensions.x / 2) - 0.5,dimensions.y - 0.5,(dimensions.z / 2) - 0.5)
	prop_spots["Top_Northwest"] = Vector3((dimensions.x / 2) - 0.5,dimensions.y - 0.5,(-dimensions.z / 2) + 0.5)

func place_prop():
	pass
