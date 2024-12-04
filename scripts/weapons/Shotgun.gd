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
		
func _shoot() -> void:
	# Implement shotgun spread pattern
	pass
