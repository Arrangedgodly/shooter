extends Weapon
class_name Knife

var is_attacking: bool = false
var attack_distance: float = 50.0
var attack_speed: float = 15.0
var start_pos: Vector2
var attack_rate = .75
@onready var attack_rate_timer: Timer = $AttackRateTimer

func _ready() -> void:
	super._ready()
	attack_rate_timer.wait_time = attack_rate

func _physics_process(delta: float) -> void:
	if is_attacking:
		var attack_dir = Vector2.RIGHT.rotated(rotation)
		position += attack_dir * attack_speed
		
		if position.distance_to(start_pos) >= attack_distance:
			position = start_pos
			is_attacking = false

func attack() -> void:
	if is_attacking or !attack_rate_timer.is_stopped():
		return
	
	start_pos = position
	is_attacking = true
	attack_rate_timer.start()
	var fire_rate_scene = get_tree().get_first_node_in_group("fire-rate")
	fire_rate_scene.init(attack_rate)
