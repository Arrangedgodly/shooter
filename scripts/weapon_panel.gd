extends TextureRect

const NON_SELECTED = preload("res://assets/Updated_ZombiePack_AssetPack/UI/panel 2 (32x32).png")
const SELECTED = preload("res://assets/Updated_ZombiePack_AssetPack/UI/panel 1 (32x32).png")

@onready var locked_shader = preload("res://shaders/locked.tres").duplicate()
var weapon_sprite: Node2D
var weapon_name: String
var is_unlocked: bool = false

func setup(name: String) -> void:
	weapon_name = name
	weapon_sprite = WeaponData.WEAPONS[name].scene.instantiate()
	add_child(weapon_sprite)
	
	var rect_size = self.size
	weapon_sprite.position = rect_size / 2
	weapon_sprite.scale = Vector2(2, 2)
	weapon_sprite.material = locked_shader

func set_selection(new_selection: bool) -> void:
	if !is_unlocked:
		return
		
	texture = SELECTED if new_selection else NON_SELECTED

func unlock() -> void:
	weapon_sprite.material = null
	is_unlocked = true
