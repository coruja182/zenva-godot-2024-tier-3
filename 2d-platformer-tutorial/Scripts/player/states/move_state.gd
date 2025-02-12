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

	if Input.is_action_just_pressed("jump") and player.can_jump():
		player.jump(delta)
		player.change_state("Jump")

	if Input.is_action_just_pressed("dash") and player.can_dash and player.is_on_floor():
		player.change_state("Dash")

	if player.velocity.y > 0:
		player.change_state("fall")
