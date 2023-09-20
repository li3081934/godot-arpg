extends AnimatedSprite2D
@export var animation_name = 'default'

func _ready():
	frame = 0
	play(animation_name)
	connect("animation_finished", _on_animated_finished)


func _on_animated_finished():
	queue_free()
