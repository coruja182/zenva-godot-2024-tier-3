extends TileMapLayer
class_name Platform


var speed: int = 100
var platform_size: int = 2
var _TILE_WIDTH: int = 40

@onready var coin: PackedScene = preload("res://Scenes/coin.tscn")


func _physics_process(delta: float) -> void:
	if visible:
		position.x -= speed * delta


## Draw platforms based on the platform_size variable
func set_platforms():
	# Clear existing tiles
	clear()
	# Set new tiles based on platform_size
	for i in range(0, platform_size):
		var l_coords = Vector2i(i, 0)
		var l_source_id = 1
		var l_atlas_coords = Vector2i.ZERO
		set_cell(l_coords, l_source_id, l_atlas_coords)

	add_coins()


func get_visible_rect() -> Rect2:
	var rect = Rect2()
	rect.position = global_position
	rect.size = Vector2(platform_size * _TILE_WIDTH, _TILE_WIDTH)
	return rect


func add_coins() -> void:
	for tile_index in range(platform_size):
		var coin_temp = coin.instantiate()
		add_child(coin_temp)
		coin_temp.position = Vector2(tile_index * _TILE_WIDTH + _TILE_WIDTH / 2.0, -_TILE_WIDTH)
