extends State
class_name JumpState


@onready var player : PlayerController = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func reset_node() -> void:
	player.jump_count = 0
	player.can_dash = true
	player.animation.play("Idle")
