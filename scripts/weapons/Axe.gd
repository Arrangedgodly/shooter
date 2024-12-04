extends Weapon
class_name Axe

var is_attacking: bool = false
var attack_speed: float = 12.0
var attack_offset: float = 0.0
var attack_radius: float = 60.0  # Increased for a wider swing
var initial_position: Vector2
var pivot_point: Vector2
var swing_start_offset: float = -PI/2  # Start swing from behind
var swing_end_offset: float = PI/3    # End swing in front
var initial_aim_rotation: float       # Store the aim direction when attack starts

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	if is_attacking:
		# Start from behind (-PI/2) and swing forward to PI/3
		# We use a smoothed progression for more natural motion
		attack_offset += attack_speed * delta
		
		# Convert our linear attack_offset into a smooth arc motion
		var swing_progress = clamp(attack_offset / PI, 0.0, 1.0)
		var current_angle = lerp(swing_start_offset, swing_end_offset, ease(swing_progress, 0.5))
		
		# If we've completed the swing
		if swing_progress >= 1.0:
			is_attacking = false
			attack_offset = 0.0
			position = initial_position
			return
			
		# Calculate the swing arc following the blade direction
		# We add PI/4 to align with the blade's default 45-degree angle
		var swing_direction = Vector2.RIGHT.rotated(initial_aim_rotation + current_angle + PI/4)
		position = pivot_point + swing_direction * attack_radius
		
		# The rotation should lead the position slightly for a more natural look
		# We add PI/4 again to maintain alignment with the blade sprite
		rotation = initial_aim_rotation + current_angle + PI/4

func attack() -> void:
	if is_attacking:
		return
		
	is_attacking = true
	initial_position = position
	initial_aim_rotation = rotation - PI/4  # Subtract PI/4 to account for blade angle
	pivot_point = position
	attack_offset = 0.0
