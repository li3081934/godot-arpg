extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.play('effect')


func _on_animated_sprite_2d_animation_finished():
	queue_free()
