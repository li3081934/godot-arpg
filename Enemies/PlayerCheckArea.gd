extends Area2D
var player = null

func seek_player():
	if player != null:
		return player
	return null

func _on_body_entered(body):
	player = body


func _on_body_exited(body):
	player = null
