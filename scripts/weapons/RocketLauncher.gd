extends RangedWeapon
class_name RocketLauncher

@export var explosion_radius: float = 5.0
	
func _ready() -> void:
	super._ready()
	clip_size = 1
	fire_rate = 0.5
	reload_time = 3.0
	base_damage = 50.0
	projectile_scene = preload("res://scenes/projectiles/rocket.tscn")
	init_timers()
		
func _shoot() -> void:
	var rocket = projectile_scene.instantiate()
	get_tree().root.add_child(rocket)
	rocket.global_position = global_position
	rocket.direction = Vector2.RIGHT.rotated(rotation)
	rocket.set_damage(base_damage)
	# Connect to rocket's collision for explosion
	rocket.area_entered.connect(func(_area): rocket.explode())
	rocket.body_entered.connect(func(_body): rocket.explode())
	weapon_controller.handle_projectile(rocket)
	
	super._shoot()
