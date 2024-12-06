extends Node2D
class_name WeaponController

signal weapon_type_changed(type: WeaponData.WeaponType)

@export var weapon_distance: float = 30.0
@export var weapon_follow_speed: float = 10.0

@onready var weapon: Node2D
@onready var game = get_tree().get_first_node_in_group("game")

var target_rotation: float = 0.0
var is_attacking: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		is_attacking = true
	if event.is_action_released("click"):
		is_attacking = false

func _physics_process(delta: float) -> void:
	if not weapon:
		return
	
	if is_attacking:
		weapon.attack()

	var parent = get_parent() as Node2D
	if parent:
		var target_position = parent.global_position + Vector2.RIGHT.rotated(target_rotation) * weapon_distance
		weapon.global_position = weapon.global_position.lerp(target_position, weapon_follow_speed * delta)
		
		# Only set the base rotation if the weapon isn't attacking
		if weapon is Axe:
			if not weapon.is_attacking:
				weapon.rotation = target_rotation
			else:
				# During attack, add the attack offset to the base rotation
				weapon.rotation = target_rotation + weapon.attack_offset
		else:
			weapon.rotation = target_rotation
			
		weapon.flip_v = abs(target_rotation) > PI/2

func set_aim_direction(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		target_rotation = direction.angle()

func equip_weapon(weapon_name: String) -> void:
	if not WeaponData.WEAPONS.has(weapon_name):
		return
		
	if weapon:
		if game:
			game.remove_camera_target(weapon)
		weapon.queue_free()
		
	weapon = WeaponData.WEAPONS[weapon_name].scene.instantiate()
	add_child(weapon)
	
	# Set camera target only for melee weapons
	if game and WeaponData.WEAPONS[weapon_name].type == WeaponData.WeaponType.MELEE:
		game.set_camera_target(weapon)
		
	weapon_type_changed.emit(WeaponData.WEAPONS[weapon_name].type)

# Handle projectile camera targeting
func handle_projectile(projectile: Node2D) -> void:
	var weapon_name = weapon.name.to_lower() if weapon else ""
	if weapon_name == "rocketlauncher":
		weapon_name = "rocket_launcher"
	if game and weapon and WeaponData.WEAPONS[weapon_name].type == WeaponData.WeaponType.RANGED:
		game.set_camera_target(projectile)
		
		await get_tree().create_timer(.5).timeout
		
		game.remove_camera_target(projectile)
