extends AudioStreamPlayer2D

class_name SoundEffect

func _ready():
	play()

func _on_finished():
	queue_free()
