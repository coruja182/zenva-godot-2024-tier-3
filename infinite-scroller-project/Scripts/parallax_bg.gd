extends ParallaxBackground
class_name ParallaxBG

@onready var speed: int = 50


signal game_over_signal


func _process(delta):
    scroll_offset.x -= speed * delta


func _ready():
    # connect body entered signal from platforms
    get_node("WaterArea2D").body_entered.connect(_on_water_area_2d_body_entered)


func _on_water_area_2d_body_entered(body: Node) -> void:
    if body is Player:
        game_over_signal.emit()
