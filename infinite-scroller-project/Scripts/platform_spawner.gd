extends Node


var platform_scene: PackedScene = preload("res://Scenes/platform.tscn")
var pool_size: int = 4
var platform_pool: Array = []


func _ready():
	# initialize the object pool
	for i in range(pool_size):
		var platform_temp: Platform = platform_scene.instantiate()
		platform_temp.show()
		platform_temp.platform_size = 3
		platform_temp.set_plaforms()
		platform_temp.position = Vector2(i * (40 * 3), 200)
		platform_pool.append(platform_temp)
		add_child(platform_temp)
