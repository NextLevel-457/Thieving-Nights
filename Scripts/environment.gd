extends Node3D

@export var player: Player

func _ready():
	$Moon.player = player
