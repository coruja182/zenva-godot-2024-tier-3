extends State
class_name FallState


func reset_node() -> void:
	pass


func _physics_process(delta: float) -> void:
	if player.current_state == "Fall":
		if Input.is_action_pressed("move_right"):
			player.move_left(delta)
		elif Input.is_action_pressed("move_left"):
			player.move_right(delta)

		if Input.is_action_just_pressed("jump") and (player.jump_count < player.max_jumps):
			player.jump(delta)

		if player.is_on_floor():
			player.change_state("Idle")
