extends State
class_name IdleState


func reset_node() -> void:
	player.on_enter_idle()


func _physics_process(delta: float) -> void:
	if player.current_state == "Idle":
		if Input.is_action_pressed("move_right"):
			player.change_state("Move")
		elif Input.is_action_pressed("move_left"):
			player.change_state("Move")

		if Input.is_action_just_pressed("jump") and player.can_jump():
			player.jump(delta)
			player.change_state("Jump")

		if Input.is_action_just_pressed("dash") and player.can_dash and player.is_on_floor():
			player.change_state("Dash")

		player.go_idle()
