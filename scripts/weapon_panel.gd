extends TextureRect

const NON_SELECTED = preload("res://assets/Updated_ZombiePack_AssetPack/UI/panel 2 (32x32).png")
const SELECTED = preload("res://assets/Updated_ZombiePack_AssetPack/UI/panel 1 (32x32).png")
@onready var sprite: Sprite2D = $Sprite2D

@export_enum("pistol", "shotgun", "rifle", "sniper", "axe", "rocket_launcher", "knife", "revolver") var weapon_type: String = "Pistol"

var weapon_frames: Dictionary = {
	"sniper": 0,
	"pistol": 1,
	"revolver": 2,
	"shotgun": 3,
	"axe": 6,
	"rifle": 7,
	"rocket_launcher": 8,
	"knife": 9
}

var is_selected: bool = false

func _ready() -> void:
	self.texture = NON_SELECTED
	var rect_size = self.size
	sprite.position = rect_size / 2
	sprite.frame = weapon_frames[weapon_type]
	sprite.scale = Vector2(2, 2)
