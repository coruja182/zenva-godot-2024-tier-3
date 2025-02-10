extends State
class_name IdleState


@onready var player: PlayerController = get_parent().get_parent()


func reset_node() -> void:
	player.on_enter_idle()


func _physics_process(delta: float) -> void:
	if player.current_state == "Idle":
		if Input.is_action_pressed("move_right"):
			player.change_state("Move")
		elif Input.is_action_pressed("move_left"):
			player.change_state("Move")

		if Input.is_action_just_pressed("jump") and (player.jump_count < player.max_jumps):
			player.jump_count += 1
			player.velocity.y = -player.jump_height * delta

		if Input.is_action_just_pressed("dash") and player.can_dash and player.is_on_floor():
			player.change_state("dash")
		player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION)
