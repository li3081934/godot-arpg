extends CharacterBody2D
const MAX_SPEED = 80
const ACCELERATION = 500  # 加速度
const FRICTION = 800 # 摩擦力
const MIN_DISTANCE = 25
enum {
	IDLE,
	CHASE
}
var player: CharacterBody2D = null
var state = IDLE
var targetPlayerPosition = Vector2.ZERO
@onready var animate = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().current_scene.find_child("Player", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		IDLE:
			animate.play("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		CHASE:
			state_chase(delta)
	move_and_slide()
			
func state_chase(delta):
	animate.play("Walk")
	var dir = (targetPlayerPosition - global_position).normalized()
	animate.flip_h = dir.x < 0
	velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta)
	var distance = targetPlayerPosition.distance_to(global_position)
	print(distance)
	if distance <= MIN_DISTANCE:
		state = IDLE

func seek_player():
	var distance = player.global_position.distance_to(global_position)
	if distance > MIN_DISTANCE:
		targetPlayerPosition = player.global_position
		state = CHASE
	else:
		state = IDLE
	
	
	

func _on_timer_timeout():
	if state == IDLE:
		seek_player()
