@icon("res://assets/icons/node_2D/icon_sword.png")
extends PolygonSprite
class_name Weapon

# All weapons share the animations:
# Idle and Flicker

func _ready() -> void:
	super._ready()

func attack() -> void:
	push_error("Attack method not implemented in weapon subclass")
