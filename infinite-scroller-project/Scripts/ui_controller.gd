extends CanvasLayer
class_name GUIController


@onready var score_label: Label = $ScoreLabel


func _ready():
	get_node("../ParallaxBG").game_over_signal.connect(_on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score_label.text = "Score: %d" % GameController.score


func _on_game_over() -> void:
	hide()
