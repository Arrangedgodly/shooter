extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var phantom_camera_2d: PhantomCamera2D = $PhantomCamera2D

func _ready() -> void:
	add_to_group("game") # Add self to game group
	
	# Make sure phantom_camera_2d exists before using it
	if phantom_camera_2d:
		phantom_camera_2d.follow_mode = 3
		phantom_camera_2d.set_follow_target(player)
		phantom_camera_2d.set_follow_damping(true)
		phantom_camera_2d.set_follow_damping_value(Vector2(0.25, 0.25))
		phantom_camera_2d.set_auto_zoom(true)
		phantom_camera_2d.set_auto_zoom_min(.3)
		phantom_camera_2d.set_auto_zoom_max(1)
		phantom_camera_2d.set_auto_zoom_margin(Vector4(20, 20, 20, 20))
		if player.weapon_controller.weapon:
			phantom_camera_2d.append_follow_targets(player.weapon_controller.weapon)

func set_camera_target(target: Node2D) -> void:
	if phantom_camera_2d and is_instance_valid(target):
		phantom_camera_2d.append_follow_targets(target)

func remove_camera_target(target: Node2D) -> void:
	if phantom_camera_2d and is_instance_valid(target):
		phantom_camera_2d.erase_follow_targets(target)
		phantom_camera_2d.erase_follow_targets(player)
	
	set_camera_target(player)
