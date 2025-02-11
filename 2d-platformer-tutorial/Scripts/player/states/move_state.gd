extends State
class_name MoveState


func reset_node() -> void:
	player.animation.play("Move")


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		player.move_left(delta)
	elif Input.is_action_pressed("move_left"):
		player.move_right(delta)
	else:
		player.change_state("Idle")

	if Input.is_action_just_pressed("jump") and (player.jump_count < player.max_jumps):
		player.jump(delta)
		player.change_state("Jump")

	if Input.is_action_just_pressed("dash") and player.can_dash and player.is_on_floor():
		player.change_state("Dash")
	player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION)