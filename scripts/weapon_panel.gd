extends TextureRect

const NON_SELECTED = preload("res://assets/Updated_ZombiePack_AssetPack/UI/panel 2 (32x32).png")
const SELECTED = preload("res://assets/Updated_ZombiePack_AssetPack/UI/panel 1 (32x32).png")

@onready var locked_shader = preload("res://shaders/locked.tres").duplicate()
var weapon

var is_unlocked: bool = false

func _ready() -> void:
	self.texture = NON_SELECTED
	
func set_weapon(new_weapon: Weapon) -> void:
	weapon = new_weapon
	var rect_size = self.size
	weapon.position = rect_size / 2
	weapon.scale = Vector2(2, 2)
	weapon.material = locked_shader

func set_selection(new_selection: bool) -> void:
	if !is_unlocked:
		return
		
	if new_selection:
		self.texture = SELECTED
	else:
		self.texture = NON_SELECTED

func unlock() -> void:
	weapon.material = null
	is_unlocked = true
