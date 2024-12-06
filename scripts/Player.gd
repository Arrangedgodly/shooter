extends CharacterBody2D

@export var max_speed: float = 400.0
@export var acceleration: float = 2000.0
@export var deceleration: float = 1000.0
@export var controller_aim_speed: float = 400.0

@onready var aim_direction: Vector2 = Vector2.RIGHT
@onready var square_crosshair_scene = preload("res://scenes/square_crosshair.tscn")
@onready var circle_crosshair_scene = preload("res://scenes/circle_crosshair.tscn")
@onready var weapon_controller: WeaponController = $WeaponController
@onready var sprite: PolygonSprite = $AnimatedSprite2D

var square_crosshair: Crosshair
var circle_crosshair: Crosshair
enum WeaponType { MELEE, RANGED }
var active_weapon_type: WeaponType = WeaponType.MELEE
var use_controller_aim: bool = false
var attack_range: float = 50.0
var ammo_storage: Dictionary = {
	"pistol": 36,    # 3 clips
	"shotgun": 24,   # 4 clips
	"revolver": 24,  # 4 clips
	"sniper": 12,    # 3 clips
	"rifle": 120,    # 4 clips
	"rocket": 3      # 3 rockets
}
var max_ammo_storage: Dictionary = {
	"pistol": 60,    # 5 clips
	"shotgun": 36,   # 6 clips
	"revolver": 36,  # 6 clips
	"sniper": 20,    # 5 clips
	"rifle": 180,    # 6 clips
	"rocket": 5      # 5 rockets
}

func _ready() -> void:
	setup_crosshairs()
	weapon_controller.weapon_type_changed.connect(update_weapon_type)
	weapon_controller.equip_weapon("knife")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if circle_crosshair.visible:
			circle_crosshair.animate()
		else:
			square_crosshair.animate()

func _physics_process(delta: float) -> void:
	# Movement
	var input_vector = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(
			input_vector * max_speed,
			acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			deceleration * delta
		)
	
	move_and_slide()
	
	# Aiming
	if use_controller_aim:
		_handle_controller_aim(delta)
	else:
		_handle_mouse_aim()
	
	weapon_controller.set_aim_direction(aim_direction)
	_update_crosshair()
	
	if velocity != Vector2.ZERO:
		sprite.play("run")
	else:
		sprite.play("idle")

	sprite.flip_h = aim_direction.x > 0

func _handle_mouse_aim() -> void:
	aim_direction = (get_global_mouse_position() - global_position).normalized()

func _handle_controller_aim(delta: float) -> void:
	var aim_input = Vector2(
		Input.get_axis("aim_left", "aim_right"),
		Input.get_axis("aim_up", "aim_down")
	)
	
	if aim_input.length() > 0.1:
		aim_direction = aim_input.normalized()

func setup_crosshairs() -> void:
	if use_controller_aim:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	square_crosshair = square_crosshair_scene.instantiate()
	circle_crosshair = circle_crosshair_scene.instantiate()
	add_child(square_crosshair)
	add_child(circle_crosshair)

	update_crosshair_visibility()
	
func _update_crosshair() -> void:
	var target_position = global_position + (aim_direction * attack_range)
	
	if active_weapon_type == WeaponType.MELEE:
		square_crosshair.global_position = target_position
	else:
		circle_crosshair.global_position = target_position

func update_crosshair_visibility() -> void:
	if square_crosshair and circle_crosshair:
		square_crosshair.visible = (active_weapon_type == WeaponType.MELEE)
		circle_crosshair.visible = (active_weapon_type == WeaponType.RANGED)

func switch_weapon(new_weapon: String) -> void:
	weapon_controller.equip_weapon(new_weapon)
	update_crosshair_visibility()

func update_weapon_type(new_type: WeaponType) -> void:
	active_weapon_type = new_type
	update_crosshair_visibility()

func reload_current_weapon() -> void:
	var weapon = weapon_controller.weapon
	if not weapon is RangedWeapon:
		return
		
	var weapon_type = weapon.name.to_lower()
	if weapon_type == "rocketlauncher":
		weapon_type = "rocket_launcher"
	if weapon.current_ammo < weapon.clip_size and ammo_storage[weapon_type] > 0:
		var ammo_needed = weapon.clip_size - weapon.current_ammo
		var ammo_available = min(ammo_needed, ammo_storage[weapon_type])
		
		weapon.current_ammo += ammo_available
		ammo_storage[weapon_type] -= ammo_available
		weapon.reload()

func add_ammo(weapon_type: String, amount: int) -> void:
	if weapon_type in ammo_storage:
		ammo_storage[weapon_type] = min(
			ammo_storage[weapon_type] + amount,
			max_ammo_storage[weapon_type]
		)
