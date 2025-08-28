class_name Unit extends CharacterBody2D


@export var max_health : int = 100
@export var damage : int = 20
@export var move_speed : float = 50.0
@export var attack_range : float = 20.0
@export var attack_rate : float = 0.2
@export var is_player : bool = false

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: Sprite2D = $Sprite


var health : int
var last_attack_time : float
var target : Unit : 
	set = set_target


func _ready() -> void:
	print(global_position)
	health = max_health
	
	var gm = get_node("/root/Main") as GameManager
	
	if is_player:
		gm.players.append(self)
	else:
		gm.enemies.append(self)


func _process(delta: float) -> void:
	_target_check()


func _physics_process(delta: float) -> void:
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var direction = global_position.direction_to(navigation_agent_2d.get_next_path_position())
	velocity = direction * move_speed
	
	move_and_slide()


func _target_check():
	if target != null:
		var dist = global_position.distance_to(target.global_position)
		
		if dist <= attack_range:
			navigation_agent_2d.target_position = global_position
			_try_attack_target()
		else:
			navigation_agent_2d.target_position = target.global_position


func set_target(p_new_target : Unit) -> void:
	target = p_new_target


func move_to_location(p_location : Vector2) -> void:
	target = null
	navigation_agent_2d.target_position = p_location


func _try_attack_target() -> void:
	var current_time = Time.get_unix_time_from_system()
	if current_time - last_attack_time > attack_rate:
		target.take_damage(damage)
		last_attack_time = current_time


func take_damage(p_damage_to_take : int) -> void:
	health = clamp(health - p_damage_to_take, 0, max_health)
	
	if health <= 0:
		print_debug("unit ", self.name, " died")
		queue_free()
		
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

# to be implemented by subclasses
func toggle_selection_visual_sprite(value: bool):
	pass
