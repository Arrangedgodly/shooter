extends CanvasLayer

@export var player: CharacterBody2D
@onready var weapons: HBoxContainer = $HBoxContainer
const WEAPON_PANEL = preload("res://scenes/weapon_panel.tscn")

var unlocked_weapons: Dictionary = {}
var current_weapon_index: int = 0
var weapon_names: Array[String] = []

func _ready() -> void:
	setup_weapon_ui()
	weapon_names.assign(WeaponData.WEAPONS.keys())
	unlock_weapon("knife")
	unlock_weapon("axe")
	unlock_weapon("pistol")
	unlock_weapon("revolver")
	unlock_weapon("rifle")
	unlock_weapon("shotgun")
	unlock_weapon("sniper")
	unlock_weapon("rocket_launcher")
	change_active_weapon("knife")
	Console.pause_enabled = true
	Console.add_command("unlock", unlock_weapon, 1)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				cycle_weapon(-1)
			MOUSE_BUTTON_WHEEL_DOWN:
				cycle_weapon(1)

func cycle_weapon(direction: int) -> void:
	var new_index = current_weapon_index
	var attempts = 0
	
	while attempts < weapon_names.size():
		new_index = (new_index + direction) % weapon_names.size()
		if new_index < 0:
			new_index = weapon_names.size() - 1
			
		if unlocked_weapons[weapon_names[new_index]]:
			current_weapon_index = new_index
			change_active_weapon(weapon_names[new_index])
			break
			
		attempts += 1

func setup_weapon_ui() -> void:
	for weapon_name in WeaponData.WEAPONS:
		var weapon_panel = WEAPON_PANEL.instantiate()
		weapons.add_child(weapon_panel)
		weapon_panel.setup(weapon_name)
		unlocked_weapons[weapon_name] = false

func change_active_weapon(weapon_name: String) -> void:
	if player:
		player.switch_weapon(weapon_name)
	
	for panel in weapons.get_children():
		panel.set_selection(panel.weapon_name == weapon_name)

func unlock_weapon(weapon_name: String) -> void:
	if weapon_name in unlocked_weapons:
		unlocked_weapons[weapon_name] = true
		for panel in weapons.get_children():
			if panel.weapon_name == weapon_name:
				panel.unlock()
