extends Node2D
class_name WeaponController
signal weapon_type_changed(type: WeaponType)

@export var weapon_distance: float = 30.0
@export var weapon_follow_speed: float = 10.0

@onready var weapon: Weapon
var target_rotation: float = 0.0
var weapon_scenes: Dictionary = {
	"knife": preload("res://scenes/weapons/knife.tscn"),
	"axe": preload("res://scenes/weapons/axe.tscn"),
	"pistol": preload("res://scenes/weapons/pistol.tscn"),
	"revolver": preload("res://scenes/weapons/revolver.tscn"),
	"rifle": preload("res://scenes/weapons/rifle.tscn"),
	"rocket_launcher": preload("res://scenes/weapons/rocket_launcher.tscn"),
	"shotgun": preload("res://scenes/weapons/shotgun.tscn"),
	"sniper": preload("res://scenes/weapons/sniper.tscn")
}

enum WeaponType { MELEE, RANGED }

func _physics_process(delta: float) -> void:
	if not weapon:
		return

	var parent = get_parent() as Node2D
	if parent:
		var target_position = parent.global_position + Vector2.RIGHT.rotated(target_rotation) * weapon_distance
		weapon.global_position = weapon.global_position.lerp(target_position, weapon_follow_speed * delta)
		
		weapon.rotation = target_rotation
		weapon.flip_v = abs(target_rotation) > PI/2

func set_aim_direction(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		target_rotation = direction.angle()

func equip_weapon(weapon_name: String) -> void:
	if not weapon_scenes.has(weapon_name):
		return
		
	if weapon:
		weapon.queue_free()
		
	weapon = weapon_scenes[weapon_name].instantiate()
	add_child(weapon)
	
	if weapon_name == "knife" or weapon_name == "axe":
		weapon_type_changed.emit(WeaponType.MELEE)
	else:
		weapon_type_changed.emit(WeaponType.RANGED)

func get_current_weapon() -> Weapon:
	return weapon
