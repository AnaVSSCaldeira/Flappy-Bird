extends Marker2D

signal game_over

@onready var timer: Timer = get_node("Timer")

@export var spawn_cooldown: float
@export var pipe_scene: PackedScene

func spawn():
	var pipe: Pipe = pipe_scene.instantiate()
	pipe.global_position = random_position()
	var _game_over = connect("game_over", pipe.game_over)
	add_child(pipe)
	timer.start(spawn_cooldown)

func _on_timeout():
	spawn()

func random_position():
	randomize()
	var random_number: float = randf_range(-118, 62)
	return Vector2(0, random_number)

func game_over_():
	timer.stop()
	emit_signal("game_over")
