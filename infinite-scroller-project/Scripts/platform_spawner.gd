extends Node
class_name PlatformSpawner


@onready var player: Player = %Player

var platform_scene: PackedScene = preload("res://Scenes/platform.tscn")
var pool_size: int = 3
var platform_pool: Array[Platform] = []

var _last_platform_added: Platform
var _PLATFORM_INITIAL_LENGTH: int = 3
var _TILE_WIDTH: int = 40
var _MIN_SPAWN_Y: int = 100
var _MAX_SPAWN_Y: int = 220
var DEFAULT_SPACING: int = _TILE_WIDTH * 2


func _ready() -> void:
	_initialize_platform_pool()
	GameController.score = 0


func _physics_process(_delta) -> void:

	if _has_space_for_new_platform():
		_last_platform_added = add_platform()

	# check for platforms that have moved out of the screen and reset them
	for platform in platform_pool:
		if platform.visible and platform.get_visible_rect().end.x < 0:
			reset_platform(platform)


## Initializes the platform object pool
func _initialize_platform_pool() -> void:
	# initialize the object pool
	for i_platform_index in range(pool_size):
		var platform_temp: Platform = create_platform()
		platform_temp.platform_size = _PLATFORM_INITIAL_LENGTH
		platform_temp.set_platforms()
		platform_temp.position = Vector2( player.global_position.x + i_platform_index * (_TILE_WIDTH * _PLATFORM_INITIAL_LENGTH) + DEFAULT_SPACING * i_platform_index, _MAX_SPAWN_Y)
		platform_pool.append(platform_temp)
		_last_platform_added = platform_temp
		platform_temp.show()


## Instantiates a new platform and adds it to the platform pool
func create_platform() -> Platform:
	var platform: Platform = platform_scene.instantiate()
	platform.hide()
	add_child(platform)
	platform_pool.append(platform)
	return platform


## Hides and sends a platform back to the platform pool
func reset_platform(platform: Platform) -> void:
	# Doing my own approach here ...
	# Get the viewpoert size
	platform.global_position = get_viewport().get_visible_rect().end + Vector2(1, 0)
	platform.hide()



## Configures and shows a platform from the pool or creates a new one if none are available
func add_platform() -> Platform:
	var platform_found: Platform = null

	# try to find a hidden platform in the pool
	for i_platform in platform_pool:
		if not i_platform.visible and platform_found == null:
			platform_found = i_platform

	if platform_found == null:
		# no hidden platform found, create a new one
		platform_found = create_platform()

	# configure the platform
	platform_found.platform_size = randi_range(2,5)
	platform_found.set_platforms()
	var position_x = get_viewport().get_visible_rect().end.x
	var position_y = randi_range(_MIN_SPAWN_Y, _MAX_SPAWN_Y)
	platform_found.position = Vector2(position_x, position_y)
	platform_found.show()
	return platform_found


## Checks if there is space for a new platform to be added
func _has_space_for_new_platform() -> bool:
	return _last_platform_added.get_visible_rect().end.x < get_viewport().get_visible_rect().end.x - DEFAULT_SPACING
