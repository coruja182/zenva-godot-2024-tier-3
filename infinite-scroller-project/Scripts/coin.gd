extends Area2D
class_name Coin


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready():
	audio_stream_player_2d.finished.connect(_on_audio_stream_player_2d_finished)
	audio_stream_player_2d.volume_db = -10
	body_entered.connect(_on_body_entered)
	animation_player.play("spin")


func _on_audio_stream_player_2d_finished() -> void:
	self.queue_free()


func _on_body_entered(_body: Node) -> void:
	# check if the body that entered is the player
	if _body is Player:
		audio_stream_player_2d.play()
		# disable the collision shape to prevent multiple collections
		hide()
		collision_shape_2d.call_deferred("set_disabled", true)
		GameController.increase_score(1)
