extends Projectile
class_name ShotgunPellet
	
func _ready() -> void:
	super._ready()
	speed = 1000.0
	lifetime = 0.5
