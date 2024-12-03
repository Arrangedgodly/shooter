extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var phantom_camera_2d: PhantomCamera2D = $PhantomCamera2D

func _ready() -> void:
	phantom_camera_2d.follow_mode = 5
	phantom_camera_2d.set_follow_target(player)
	phantom_camera_2d.show_viewfinder_in_play = true
	phantom_camera_2d.set_follow_damping(true)
