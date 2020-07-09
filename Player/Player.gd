extends KinematicBody2D

const SPEED = 1000
const GRAVITY = 300
const UP = Vector2.UP		# Vector2(0, -1)
const JUMP_SPEED = 3500

signal animate
var isJumping = false 	 	# bool flag to smooth jumping right after moving left/right
var motion = Vector2.ZERO

func _physics_process(delta):
	apply_Gravity()
	Jump()
	Move()
	Animate()
	move_and_slide(motion, UP)


func apply_Gravity():
	if is_on_floor():
		motion.y = 0
		isJumping = false
	else: 
		motion.y += GRAVITY


func Jump():
	if Input.is_action_pressed("jump") and isJumping == false:
		isJumping = true
		motion.y -= JUMP_SPEED


func Move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0


func Animate():
	emit_signal("animate", motion)








