extends Projectile
class_name Rocket
@export var explosion_radius: float = 150.0
@export var explosion_force: float = 500.0
	
func _ready() -> void:
	super._ready()
	speed = 600.0
	lifetime = 3.0
	
func explode() -> void:
	# Create explosion effect and apply area damage
	var explosion = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
		
	circle_shape.radius = explosion_radius
	collision_shape.shape = circle_shape
	explosion.add_child(collision_shape)
		
	# Add explosion to scene at current position
	get_tree().get_root().add_child(explosion)
	explosion.global_position = global_position
		
	# Handle area damage
	var bodies = explosion.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			# Calculate damage falloff based on distance
			var distance = body.global_position.distance_to(global_position)
			var damage_multiplier = 1.0 - (distance / explosion_radius)
			body.take_damage(damage * damage_multiplier)
		
	# Clean up
	explosion.queue_free()
	queue_free()
