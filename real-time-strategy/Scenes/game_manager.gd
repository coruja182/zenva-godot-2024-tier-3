extends Node2D
class_name GameManager

var selected_unit : Unit
var players : Array[Unit]
var enemies : Array[Unit]


enum MouseAction {
	LEFT_CLICK,
	RIGHT_CLICK,
	NONE
}


func _input(p_event: InputEvent) -> void:
	var mouse_event_type = _get_mouse_event(p_event)
	if mouse_event_type == MouseAction.LEFT_CLICK:
		_try_select_unit()
	elif mouse_event_type == MouseAction.RIGHT_CLICK:
		_try_command_unit()
	

func _get_mouse_event(p_event: InputEvent) -> MouseAction :
	if p_event is InputEventMouseButton and p_event.is_pressed():
		if p_event.button_index == MOUSE_BUTTON_LEFT:
			return MouseAction.LEFT_CLICK
		elif p_event.button_index == MOUSE_BUTTON_RIGHT:
			return MouseAction.RIGHT_CLICK
	
	return MouseAction.NONE


func _get_selected_unit() -> Node2D:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection : Array[Dictionary]  = space.intersect_point(query, 1)

	if !intersection.is_empty():
		return intersection[0].collider

	return null


func _try_select_unit():
	var unit_or_null = _get_selected_unit()
	if unit_or_null != null and unit_or_null is Unit and unit_or_null.is_player:
		_select_unit(unit_or_null)
	else:
		_unselect_unit()


func _select_unit(p_unit: Unit):
	_unselect_unit()
	selected_unit = p_unit
	selected_unit.toggle_selection_visual_sprite(true)


func _unselect_unit():
	pass


func _try_command_unit():
	pass
