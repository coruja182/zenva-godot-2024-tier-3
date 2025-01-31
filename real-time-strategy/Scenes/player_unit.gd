extends Unit
class_name PlayerUnit

@onready var _selection_visual_sprite: Sprite2D = $SelectionVisualSprite


func toggle_selection_visual_sprite(p_toggle : bool) -> void:
	_selection_visual_sprite.visible = p_toggle
