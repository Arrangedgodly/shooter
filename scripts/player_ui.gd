extends CanvasLayer

@export var player: CharacterBody2D
var active_weapon: String
@onready var weapons: HBoxContainer = $HBoxContainer

func _ready() -> void:
	active_weapon = "knife"
	unlock_weapon("knife")
	change_active_weapon(active_weapon)
	Console.add_command("unlock", unlock_weapon, 1)

func change_active_weapon(new_weapon: String) -> void:
	for weapon in weapons.get_children():
		if weapon.weapon_type == new_weapon:
			weapon.set_selection(true)
		else:
			weapon.set_selection(false)

func unlock_weapon(new_weapon: String) -> void:
	for weapon in weapons.get_children():
		if weapon.weapon_type == new_weapon:
			weapon.unlock()

func _exit_tree() -> void:
	Console.remove_command("unlock")
