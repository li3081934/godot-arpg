extends CharacterBody2D
@onready var stats = $Stats
@onready var playerCheck = $PlayerCheckArea
var BatEffect = preload("res://Effects/Bat_effect.tscn")

const HIT_BACK_SPEED = 120
const MOVE_SPEED = 50
const FRICTION = 250 # 摩擦力
const ACCELERATION = 200
enum {
	IDLE,
	CHASE,
	WANDER
}
var status = IDLE
var targetPlayer = null

func _physics_process(delta):
	match status:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		WANDER:
			pass
		CHASE:
			status_chase(delta)
	seek_player()
	move_and_slide()
	
func status_chase(delta):
	var dir = (targetPlayer.global_position - global_position).normalized()
	velocity = velocity.move_toward(dir * MOVE_SPEED, ACCELERATION * delta )
	
func seek_player():
	targetPlayer = playerCheck.seek_player()
	if targetPlayer != null:
		status = CHASE
	else:
		status = IDLE

func _on_area_2d_area_entered(area):
	stats.health -= area.damage
	velocity = area.hit_vector * HIT_BACK_SPEED


func _on_stats_health_empty():
	queue_free()
	var barEffect = BatEffect.instantiate()
	barEffect.global_position = global_position
	var parent = get_parent()
	parent.add_child(barEffect)
