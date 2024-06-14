extends MeshInstance3D

@export var player: Player
var og_position: Vector3

func _ready():
	og_position = position

func _physics_process(delta):
	position = player.position + og_position
