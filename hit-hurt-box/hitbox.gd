extends Area2D
var HitEffect = preload("res://Effects/Hit_effect.tscn")

@export var damage: int = 1
@export var hit_vector: Vector2 = Vector2.DOWN


func _on_area_entered(area):
	var hitEffect = HitEffect.instantiate()
	hitEffect.global_position = area.global_position
	var world = get_tree().current_scene
	world.add_child(hitEffect)
