@icon("res://assets/icons/node_2D/icon_bullet.png")
extends Weapon
class_name RangedWeapon

# Base stats for ranged weapons
var clip_size: int = 12
var base_damage: float = 10.0
var projectile_scene: PackedScene
var fire_rate: float = 1.0
var reload_time: float = 1.0

# Current state
var current_ammo: int
var can_shoot: bool = true
var is_reloading: bool = false
var weapon_controller: WeaponController

# Timer for managing fire rate
@export var fire_rate_timer: Timer
@export var reload_timer: Timer

func _ready() -> void:
	super._ready()
	weapon_controller = get_parent() as WeaponController
	
	# Start with a full clip
	current_ammo = clip_size

func attack() -> void:
	if can_shoot and current_ammo > 0 and not is_reloading:
		self.play("shoot")
		_shoot()
		can_shoot = false
		fire_rate_timer.start()
		current_ammo -= 1

func reload() -> void:
	if not is_reloading and current_ammo < clip_size:
		is_reloading = true
		reload_timer.start()

func _shoot() -> void:
	var fire_rate_scene = get_tree().get_first_node_in_group("fire-rate")
	fire_rate_scene.init(fire_rate)
	
func init_timers() -> void:
	fire_rate_timer.wait_time = fire_rate
	fire_rate_timer.one_shot = true
	fire_rate_timer.timeout.connect(_on_fire_rate_timeout)
	
	reload_timer.wait_time = reload_time
	reload_timer.one_shot = true
	reload_timer.timeout.connect(_on_reload_complete)

func _on_fire_rate_timeout() -> void:
	can_shoot = true

func _on_reload_complete() -> void:
	current_ammo = clip_size
	is_reloading = false
