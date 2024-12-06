extends RangedWeapon
class_name AssaultRifle

func _ready() -> void:
	super._ready()
	clip_size = 50
	fire_rate = .05
	reload_time = 2.0
	base_damage = 12.0
	projectile_scene = preload("res://scenes/projectiles/rifle_bullet.tscn")
	init_timers()
		
func _shoot() -> void:
	var bullet = projectile_scene.instantiate()
	bullet.global_position = global_position
	# Add slight spread for assault rifle
	var spread = randf_range(-0.1, 0.1)
	bullet.direction = Vector2.RIGHT.rotated(rotation + spread)
	bullet.set_damage(base_damage)
	get_tree().root.add_child(bullet)
	weapon_controller.handle_projectile(bullet)
	
	super._shoot()
