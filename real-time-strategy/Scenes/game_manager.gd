extends Node2D
class_name GameManager

var selected_unit : Unit
var players : Array[Unit]
var enemies : Array[Unit]


func _get_selected_unit():
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection : Array[Dictionary]  = space.intersect_point(query, 1)

	if !intersection.is_empty():
		return intersection[0].collider

	return null


func _try_selected_unit():
	pass


func _selected_unit(unit: Unit):
	pass


func _unselected_unit(unit: Unit):
	pass


func _try_command_unit(unit: Unit):
	pass
