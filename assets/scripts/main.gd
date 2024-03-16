extends Node2D

@onready var bird: CharacterBody2D = get_node("Bird")
@onready var interface: CanvasLayer = get_node("Interface")
@onready var parallax_background: ParallaxBackground = get_node("ParallaxBackground")
@onready var pipe_spawner: Marker2D = parallax_background.get_node("PipeSpawner")

func _ready():
	var _start = interface.connect("start_game", start_game_func)
	var _game_over = bird.connect("game_over", game_over_func)

func start_game_func():
	bird.start()
	pipe_spawner.spawn()

func game_over_func():
	interface.game_over()
	parallax_background.game_over()
	pipe_spawner.game_over_()
