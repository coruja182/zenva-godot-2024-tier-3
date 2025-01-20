extends CanvasLayer
class_name GameOverController


func _ready():
	get_node("../ParallaxBG").game_over_signal.connect(_on_game_over)
	get_node("./RetryButton").pressed.connect(_on_retry_button_pressed)
	hide()


func _on_game_over() -> void:
	get_node("./ScoreLabel").text = "Final Score: %d" % GameController.score
	get_tree().paused = true
	show()


func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
