extends CharacterBody2D
class_name PlayerController


@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var debug_state: Label = $DebugState

var max_speed: int = 8000
var acceleration: int = 1000
var jump_height: int = 15000
var direction: float = 0.0

const JUMP_VELOCITY = -400.0
const FRICTION: float = 0.22
const WEIGHT: float = 0.35


# State Machine Related Code #
var current_state: String = ""
var can_dash: bool = true
var max_jumps: int = 3
var jump_count: int = 0


func _ready():
	change_state("Idle")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		var target_velocity: float = min(velocity.y + acceleration * delta, max_speed)
		velocity.y = lerp(velocity.y, target_velocity, 0.6)

	direction = Input.get_axis("ui_left", "ui_right")

	if direction < 0:
		animation.flip_h = false
	elif direction > 0:
		animation.flip_h = true

	move_and_slide()


func change_state(new_state: String) -> void:
	current_state = new_state
	for state_it in get_node("States").get_children():
		if state_it is State:
			if state_it.name == "%sState" % current_state:
				state_it.reset_node()
				break
	debug_state.text = "State: %s" % new_state


func on_enter_idle() -> void:
	jump_count = 0
	can_dash = true
	animation.play("Idle")


func go_idle() -> void:
	velocity.x = lerp(velocity.x, 0.0, FRICTION)


func can_jump() -> bool:
	return jump_count < max_jumps


func jump(delta: float) -> void:
	jump_count += 1
	velocity.y = - jump_height * delta


func move_left(delta: float) -> void:
	var target_velocity: float = min(velocity.x + acceleration * delta, max_speed * delta)
	velocity.x = lerp(velocity.x, target_velocity, WEIGHT)


func move_right(delta: float) -> void:
	var target_velocity: float = min(velocity.x - acceleration * delta, -max_speed * delta)
	velocity.x = lerp(velocity.x, target_velocity, WEIGHT)
