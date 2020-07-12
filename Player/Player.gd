extends KinematicBody2D

const SPEED = 1000
const GRAVITY = 150
const UP = Vector2.UP		# Vector2(0, -1)
const JUMP_SPEED = 2500
const WORLD_LIMIT = 3000
const BOOST_MULTIPLIER = 2
const HURT_MULTIPLIER = 1.25

signal animate

# var lives = 3
var isJumping = false 	 	# bool flag to smooth jumping right after moving left/right
var motion = Vector2.ZERO

func _physics_process(delta):
	apply_Gravity()
	Jump()
	Move()
	Animate()
	move_and_slide(motion, UP)


func apply_Gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	if is_on_floor() and motion.y > 0:
		motion.y = 0
		isJumping = false
	elif is_on_ceiling():
		motion.y = GRAVITY
	else: 
		motion.y += GRAVITY		# positive y values go down


func Jump():
	if Input.is_action_just_pressed("jump") and isJumping == false:
		isJumping = true
		motion.y -= JUMP_SPEED	# negative y values go up
		jump_sfx()


func jump_sfx():
	$JumpSFX.play()


func hurt_sfx():
	$HurtSFX.play()


func Move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0


func Animate():
	emit_signal("animate", motion)


func boost():
	position.y -= 1
	motion.y = 0
	yield(get_tree(), "idle_frame") 	
	isJumping = true
	motion.y = -JUMP_SPEED * BOOST_MULTIPLIER
	jump_sfx()


func hurt():
	position.y -= 1
	motion.y = 0
	yield(get_tree(), "idle_frame") 	# wait a frame, then jump will work as it's not affected by gravity when is_on_floor
	isJumping = true
	motion.y = -JUMP_SPEED * HURT_MULTIPLIER
	hurt_sfx()






