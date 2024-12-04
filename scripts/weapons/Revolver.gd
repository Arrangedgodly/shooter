extends RangedWeapon
class_name Revolver

func _ready() -> void:
	super._ready()
	clip_size = 6
	fire_rate = 1.5
	reload_time = 2.0
	base_damage = 30.0
		
func _shoot() -> void:
	# Implement revolver-specific shooting logic
	# High damage, medium fire rate
	pass
