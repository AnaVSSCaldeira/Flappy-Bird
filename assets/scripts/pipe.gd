extends Node2D

class_name Pipe

@onready var top_pipe: StaticBody2D = get_node("TopPipe")
@onready var bottom_pipe: StaticBody2D = get_node("BottomPipe")

@export var walk_speed: int
@export var pipe_texture: Array[String]

func _ready():
	randomize()
	var random_number: int = randi() % pipe_texture.size()
	top_pipe.get_node("Texture").texture = load(pipe_texture[random_number])
	bottom_pipe.get_node("Texture").texture = load(pipe_texture[random_number])

func _physics_process(delta: float):
	position.x -= delta * walk_speed

func _on_screen_exited():
	queue_free()

func game_over():
	top_pipe.get_node("Collision").set_deferred("disable", true)
	bottom_pipe.get_node("Collision").set_deferred("disable", true)
	set_physics_process(false)

func _on_body_exited(body:Bird):
	if body is Bird and body.global_position.x > get_node("ScoreArea/Collision").global_position.x:
		get_tree().call_group("Interface", "update_score")