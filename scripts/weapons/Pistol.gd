extends RangedWeapon
class_name Pistol

func _ready() -> void:
	super._ready()
	clip_size = 12
	fire_rate = 0.25
	reload_time = 1.2
	base_damage = 15.0
	projectile_scene = preload("res://scenes/projectiles/pistol_bullet.tscn")
	init_timers()
		
func _shoot() -> void:
	var bullet = projectile_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = Vector2.RIGHT.rotated(rotation)
	bullet.set_damage(base_damage)
	get_tree().root.add_child(bullet)
	weapon_controller.handle_projectile(bullet)
	
	super._shoot()
