extends CharacterBody2D
class_name PlayerController


@onready var animation: AnimatedSprite2D = $AnimatedSprite2D


var max_speed: int = 8000
var acceleration: int = 1000
var jump_height: int = 15000
var direction: float = 0.0

const JUMP_VELOCITY = -400.0
const FRICTION: float = 0.22
const WEIGHT: float = 0.35


# State Machine Related Code #
var current_state: String =  ""
var can_dash: bool = true
var max_jumps: int = 3
var jump_count: int = 0


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		var target_velocity : float = min(velocity.y + acceleration * delta, max_speed)
		velocity.y = lerp(velocity.y, target_velocity, 0.6)

	direction = Input.get_axis("ui_left", "ui_right")

	if direction < 0:
		animation.flip_h = false
	elif direction > 0:
		animation.flip_h = true

	move_and_slide()
