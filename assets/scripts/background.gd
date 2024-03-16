extends ParallaxBackground

@onready var background_texture: TextureRect = get_node("Background/Texture")

@export var scenario_speed: int
@export var scenario_texture: Array[String]

func _ready():
    randomize()
    var random_number: int = randi() % scenario_texture.size()
    background_texture.texture = load(scenario_texture[random_number])

func _physics_process(delta: float):
    for children in get_children():
        if children is ParallaxLayer:
            children.motion_offset.x -= scenario_speed * delta

func game_over():
    set_physics_process(false)
