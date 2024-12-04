extends Weapon
class_name Knife

var is_attacking: bool = false
var attack_distance: float = 50.0
var attack_speed: float = 15.0
var start_pos: Vector2

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	if is_attacking:
		var attack_dir = Vector2.RIGHT.rotated(rotation)
		position += attack_dir * attack_speed
		
		if position.distance_to(start_pos) >= attack_distance:
			position = start_pos
			is_attacking = false

func attack() -> void:
	if is_attacking:
		return
	
	start_pos = position
	is_attacking = true
