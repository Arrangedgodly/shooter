extends Weapon
class_name Axe

var is_attacking: bool = false
var attack_angle: float = PI  # 180 degrees
var attack_speed: float = 8.0
var initial_rotation: float
var target_rotation: float
var return_to_position: Vector2

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	if is_attacking:
		var angle_difference = wrapf(target_rotation - rotation, -PI, PI)
		if abs(angle_difference) > 0.1:
			rotation += sign(angle_difference) * attack_speed * delta
		else:
			position = return_to_position
			is_attacking = false

func attack() -> void:
	if is_attacking:
		return
		
	is_attacking = true
	initial_rotation = rotation
	target_rotation = initial_rotation + attack_angle
	return_to_position = position
