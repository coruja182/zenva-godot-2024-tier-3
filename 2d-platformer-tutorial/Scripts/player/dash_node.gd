extends AnimatedSprite2D
class_name DashNode


var direction: float


func _physics_process(delta: float) -> void:
	flip_h = (direction < 0)
	
	# move the node
	position.x -= direction

	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)
	
	if modulate.a < 0.01:
		queue_free()
