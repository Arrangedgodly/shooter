@icon("res://assets/icons/node_2D/icon_projectile.png")
extends Area2D
class_name Projectile

@export var speed: float = 800.0
@export var lifetime: float = 2.0
@export var damage: float = 10.0

var direction: Vector2 = Vector2.RIGHT
var source: Node2D  # The weapon that fired this projectile

func _ready() -> void:
	# Set up lifetime timer
	var timer = Timer.new()
	timer.wait_time = lifetime
	timer.one_shot = true
	timer.timeout.connect(queue_free)
	add_child(timer)
	timer.start()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func set_damage(new_damage: float) -> void:
	damage = new_damage
