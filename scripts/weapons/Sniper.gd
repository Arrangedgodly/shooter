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
		
func _shoot() -> void:
	# Implement sniper-specific shooting logic
	# High damage, requires charge time
	pass
