extends RangedWeapon
class_name RocketLauncher

@export var explosion_radius: float = 5.0
	
func _ready() -> void:
	super._ready()
	clip_size = 1
	fire_rate = 0.5
	reload_time = 3.0
	base_damage = 50.0
		
func _shoot() -> void:
	# Implement rocket launcher logic
	# Projectile with area damage
	pass
