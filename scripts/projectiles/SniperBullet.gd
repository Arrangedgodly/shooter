extends Projectile
class_name SniperBullet

var penetration_count: int = 3
	
func _ready() -> void:
	super._ready()
	speed = 5000.0
	lifetime = 3.0
