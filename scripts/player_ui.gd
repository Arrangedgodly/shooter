extends CanvasLayer

@export var player: CharacterBody2D
var active_weapon: Weapon
@onready var weapons: HBoxContainer = $HBoxContainer

var weapon_scenes: Dictionary = {
	"knife": preload("res://scenes/weapons/knife.tscn").instantiate(),
	"axe": preload("res://scenes/weapons/axe.tscn").instantiate(),
	"pistol": preload("res://scenes/weapons/pistol.tscn").instantiate(),
	"revolver": preload("res://scenes/weapons/revolver.tscn").instantiate(),
	"rifle": preload("res://scenes/weapons/rifle.tscn").instantiate(),
	"rocket_launcher": preload("res://scenes/weapons/rocket_launcher.tscn").instantiate(),
	"shotgun": preload("res://scenes/weapons/shotgun.tscn").instantiate(),
	"sniper": preload("res://scenes/weapons/sniper.tscn").instantiate()
}

const WEAPON_PANEL = preload("res://scenes/weapon_panel.tscn")

func _ready() -> void:
	print(weapon_scenes)
	for weapon in weapon_scenes:
		var weapon_panel = WEAPON_PANEL.instantiate()
		var weapon_scene = weapon_scenes[weapon]
		weapon_panel.set_weapon(weapon_scene)
		weapons.add_child(weapon_panel)
		
		
	active_weapon = weapon_scenes["knife"]
	unlock_weapon(active_weapon)
	change_active_weapon(active_weapon)
	
	Console.add_command("unlock", unlock_weapon, 1)

func change_active_weapon(new_weapon: Weapon) -> void:
	for weapon in weapons.get_children():
		if weapon == new_weapon:
			weapon.set_selection(true)
		else:
			weapon.set_selection(false)

func unlock_weapon(new_weapon: Weapon) -> void:
	for weapon in weapons.get_children():
		if weapon == new_weapon:
			weapon.unlock()

func _exit_tree() -> void:
	Console.remove_command("unlock")
