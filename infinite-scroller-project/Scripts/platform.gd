extends TileMapLayer
class_name Platform


var speed: int = 100
var platform_size: int = 2


func _physics_process(delta: float) -> void:
	position.x -= speed * delta


func set_plaforms():
	for i in range(0, platform_size):
		var l_coords = Vector2i(i, 0)
		var l_source_id = 1
		var l_atlas_coords = Vector2i.ZERO
		set_cell(l_coords, l_source_id, l_atlas_coords)