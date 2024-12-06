@icon("res://assets/icons/node_2D/icon_time.png")
extends AnimatedSprite2D
class_name TimerAnimation

func init(timer_duration: float) -> void:
	speed_scale = 5 / (sprite_frames.get_frame_count("default") * timer_duration)
	show()
	play("default")

func _ready() -> void:
	hide()
	animation_finished.connect(hide)
