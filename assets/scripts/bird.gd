extends CharacterBody2D

class_name Bird

signal game_over
# var bird_velocity: Vector2

var can_interact: bool = true

@onready var bird_texture: Sprite2D = get_node("Texture")
@onready var bird_animation: AnimationPlayer = get_node("Animation")

@export var texture_list: Array[String]
@export var sfx_scene: PackedScene
@export var gravity_speed: int
@export var jump_speed: int

func _ready():
	set_texture()
	set_physics_process(false)

func set_texture():
	randomize()
	var random_number: int = randi() % texture_list.size()
	bird_texture.texture = load(texture_list[random_number])

func _physics_process(delta):
	velocity.y += gravity_speed * delta
	if velocity.y > gravity_speed:
		velocity.y = gravity_speed
	
	if Input.is_action_just_pressed("ui_select") and can_interact:
		velocity.y = jump_speed
		spawn_sfx("res://assets/sfx/swoosh.ogg")
	
	move_and_slide()

func start():
	bird_animation.play("idle")
	set_physics_process(true)

func _on_body_entered(body: Object):
	if body.name != "Bird":
		velocity.x = 0
		can_interact = false
		spawn_sfx("res://assets/sfx/hit.ogg")
		# bird_animation.play("RESET")
		emit_signal("game_over")

func spawn_sfx(effect: String):
	var sfx: SoundEffect = sfx_scene.instantiate()
	sfx.stream = load(effect)
	get_tree().root.call_deferred("add_child", sfx)