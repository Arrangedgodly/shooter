extends RangedWeapon
class_name AssaultRifle

func _ready() -> void:
	super._ready()
	clip_size = 30
	fire_rate = 8.0
	reload_time = 2.0
	base_damage = 12.0
		
func _shoot() -> void:
	# Implement rifle-specific shooting logic
	# Rapid fire with moderate spread
	pass
