extends Area2D
@onready var timer = $Timer
var invincible = false:
	set(val): 
		invincible = val
		set_deferred("monitorable", !invincible)
		set_deferred("monitoring", !invincible)
			
func _on_timer_timeout():
	invincible = false

		
		
func start_invicible(duration):
	invincible = true
	timer.start(duration)
