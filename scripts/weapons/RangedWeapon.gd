@icon("res://assets/icons/node_2D/icon_bullet.png")
extends Weapon
class_name RangedWeapon

# Base stats for ranged weapons
@export var clip_size: int = 1
@export var fire_rate: float = 1.0  # Shots per second
@export var reload_time: float = 1.0
@export var base_damage: float = 10.0
@export var projectile_scene: PackedScene

# Current state
var current_ammo: int
var can_shoot: bool = true
var is_reloading: bool = false
var weapon_controller: WeaponController

# Timer for managing fire rate
var fire_rate_timer: Timer
var reload_timer: Timer

func _ready() -> void:
	super._ready()
	weapon_controller = get_parent() as WeaponController
	
	# Initialize timers
	fire_rate_timer = Timer.new()
	fire_rate_timer.one_shot = true
	fire_rate_timer.timeout.connect(_on_fire_rate_timeout)
	add_child(fire_rate_timer)
	
	reload_timer = Timer.new()
	reload_timer.one_shot = true
	reload_timer.timeout.connect(_on_reload_complete)
	add_child(reload_timer)
	
	# Start with a full clip
	current_ammo = clip_size

func attack() -> void:
	if can_shoot and current_ammo > 0 and not is_reloading:
		_shoot()
		can_shoot = false
		fire_rate_timer.start(1.0 / fire_rate)
		current_ammo -= 1

func reload() -> void:
	if not is_reloading and current_ammo < clip_size:
		is_reloading = true
		reload_timer.start(reload_time)

func _shoot() -> void:
	# To be implemented by specific weapons
	pass

func _on_fire_rate_timeout() -> void:
	can_shoot = true

func _on_reload_complete() -> void:
	current_ammo = clip_size
	is_reloading = false
