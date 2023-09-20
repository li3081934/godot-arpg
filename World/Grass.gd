extends Node2D
var GrassEffect = preload("res://Effects/GrassEffect.tscn")


func _on_area_2d_area_entered(area):
	queue_free()
	var grassEffect = GrassEffect.instantiate()
	grassEffect.global_position = global_position
	var parent = get_parent()
	parent.add_child(grassEffect)
