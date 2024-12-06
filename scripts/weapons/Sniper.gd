extends RangedWeapon
class_name Sniper
	
@export var charge_time: float = 1.0
var is_charged: bool = false
	
func _ready() -> void:
	super._ready()
	clip_size = 4
	fire_rate = 0.5
	reload_time = 2.5
	base_damage = 100.0
	projectile_scene = preload("res://scenes/projectiles/sniper_bullet.tscn")
	init_timers()
		
func _shoot() -> void:
	var bullet = projectile_scene.instantiate()
	bullet.global_position = global_position
	bullet.direction = Vector2.RIGHT.rotated(rotation)
	
	# If charged, increase damage and penetration
	if is_charged:
		bullet.set_damage(base_damage * 1.5)
		bullet.penetration_count += 1
		is_charged = false
	else:
		bullet.set_damage(base_damage)
	
	get_tree().root.add_child(bullet)
	weapon_controller.handle_projectile(bullet)
	
	super._shoot()
