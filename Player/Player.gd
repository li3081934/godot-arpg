extends CharacterBody2D

const MAX_SPEED = 80
const ACCELERATION = 500  # 加速度
const FRICTION = 500 # 摩擦力
const ROLL_SPEED = 120
@onready var anmiationState = $AnimationTree.get('parameters/playback')
@onready var hitbox = $hitbox_dir/hitbox
@onready var stats = $Stats
@onready var hurtbox = $hurt
enum {
	MOVE,
	ATTACK,
	ROLL
}

var state = MOVE
var roll_vector = Vector2.DOWN
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		ROLL:
			roll_state(delta)


func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO :
		$AnimationTree.set('parameters/Idle/blend_position', input_vector)
		$AnimationTree.set('parameters/Walk/blend_position', input_vector)
		$AnimationTree.set('parameters/Attack/blend_position', input_vector)
		$AnimationTree.set('parameters/Roll/blend_position', input_vector)
		roll_vector = input_vector
		anmiationState.travel('Walk')
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		anmiationState.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("attack") :
		state = ATTACK
	if Input.is_action_just_pressed("roll") :
		state = ROLL
	move()
	
func attack_state(delta):
	velocity = Vector2.ZERO
	hitbox.hit_vector = roll_vector
	anmiationState.travel('Attack')

func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	anmiationState.travel('Roll')
	move()
	
func attack_done():
	state = MOVE
	
func roll_done():
	velocity = velocity * 0.6
	state = MOVE
	
func move(): 
	move_and_slide()

func _on_hurt_area_entered(area):
	stats.health -= 1
	hurtbox.start_invicible(0.5)


func _on_stats_health_empty():
	queue_free()
