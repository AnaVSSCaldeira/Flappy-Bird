extends CanvasLayer

signal start_game

@onready var animation: AnimationPlayer = get_node("Animation")
@onready var score_container: Control = get_node("ScoreContainer")
@onready var button_container: Control = get_node("MessageContainer")
@export var sfx_scene: PackedScene

var score = 0

func _ready():
	animation.play("fade_out")
	for button in button_container.get_children():
		button.pressed.connect(self.on_button_pressed.bind(button))
		# button.connect("pressed", self, "on_button_pressed",[button])
		# var _game_over = connect("game_over", pipe.game_over)

func on_button_pressed(button: Button):
	match button.name:
		"Message":
			button_container.get_node("Message").hide()
			score_container.show()
			emit_signal("start_game")

		"GameOver":
			animation.play("fade_in")
			await get_tree().create_timer(1.0).timeout
			var _reload = get_tree().reload_current_scene()

func update_score():
	score += 1
	spawn_sfx("res://assets/sfx/point.ogg")
	score_container.get_node("Text").text = str(score)

func game_over():
	button_container.get_node("GameOver").show()

func spawn_sfx(effect: String):
	var sfx: SoundEffect = sfx_scene.instantiate()
	sfx.stream = load(effect)
	get_tree().root.call_deferred("add_child", sfx)
