extends Sprite2D
class_name Crosshair

@export var base_frame: int
@export var animation_frame: int

func _ready() -> void:
	self.frame = base_frame

func animate() -> void:
	self.frame = animation_frame
	await get_tree().create_timer(.05).timeout
	self.frame = base_frame
