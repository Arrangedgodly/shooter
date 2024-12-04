extends Node

const WEAPONS = {
	"knife": {
		"scene": preload("res://scenes/weapons/knife.tscn"),
		"type": WeaponType.MELEE
	},
	"axe": {
		"scene": preload("res://scenes/weapons/axe.tscn"),
		"type": WeaponType.MELEE
	},
	"pistol": {
		"scene": preload("res://scenes/weapons/pistol.tscn"),
		"type": WeaponType.RANGED
	},
	"revolver": {
		"scene": preload("res://scenes/weapons/revolver.tscn"),
		"type": WeaponType.RANGED
	},
	"rifle": {
		"scene": preload("res://scenes/weapons/rifle.tscn"),
		"type": WeaponType.RANGED
	},
	"rocket_launcher": {
		"scene": preload("res://scenes/weapons/rocket_launcher.tscn"),
		"type": WeaponType.RANGED
	},
	"shotgun": {
		"scene": preload("res://scenes/weapons/shotgun.tscn"),
		"type": WeaponType.RANGED
	},
	"sniper": {
		"scene": preload("res://scenes/weapons/sniper.tscn"),
		"type": WeaponType.RANGED
	}
}

enum WeaponType { MELEE, RANGED }
