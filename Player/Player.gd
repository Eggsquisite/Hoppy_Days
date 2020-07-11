extends KinematicBody2D

const SPEED = 1000
const GRAVITY = 150
const UP = Vector2.UP		# Vector2(0, -1)
const JUMP_SPEED = 2500
const WORLD_LIMIT = 3000

signal animate
var lives = 3
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
		end_game()
	if is_on_floor():
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


func Move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0


func Animate():
	emit_signal("animate", motion)


func hurt():
	position.y -= 1
	yield(get_tree(), "idle_frame") 	# wait a frame, then jump will work as it's not affected by gravity when is_on_floor
	motion.y -= JUMP_SPEED
	lives -= 1
	if lives <= 0:
		end_game()


func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")






