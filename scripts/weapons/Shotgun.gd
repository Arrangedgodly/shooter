extends RangedWeapon
class_name Shotgun
	
@export var pellet_count: int = 8
@export var spread_angle: float = 30.0
	
func _ready() -> void:
	super._ready()
	clip_size = 6
	fire_rate = 1.0
	reload_time = 2.0
	base_damage = 8.0  # Per pellet
	projectile_scene = preload("res://scenes/projectiles/shotgun_pellet.tscn")
	init_timers()
		
func _shoot() -> void:
	# Convert spread angle to radians
	var half_spread = deg_to_rad(spread_angle / 2)
	
	# Calculate angle between pellets
	var angle_step = (half_spread * 2) / (pellet_count - 1)
	
	# Spawn pellets in spread pattern
	for i in range(pellet_count):
		var pellet = projectile_scene.instantiate()
		pellet.global_position = global_position
		
		# Calculate spread angle for this pellet
		var spread = -half_spread + (angle_step * i)
		pellet.direction = Vector2.RIGHT.rotated(rotation + spread)
		pellet.set_damage(base_damage)
		get_tree().root.add_child(pellet)
		
		# Only track the center pellet for camera
		if i == pellet_count / 2:
			weapon_controller.handle_projectile(pellet)
	
	super._shoot()
