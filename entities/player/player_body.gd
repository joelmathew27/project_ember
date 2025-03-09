extends CharacterBody2D

var max_speed : int = 100
var acceleration : int = 1500
var friction : int = 600

var input = Vector2.ZERO

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	if (Input.is_action_pressed("ui_sprint")):
		acceleration = 2500
		max_speed = 200
	else:
		acceleration = 1500
		max_speed = 100

	return input.normalized()


func _physics_process(delta):
	player_movement(delta)
	play_anim(delta)
	
#TODO Remake movement to be smooth and 8 directional
func player_movement(delta):
	# if Input.is_action_pressed("ui_right"):
	# 	velocity.x = speed
	# 	#velocity.y = 0
	# elif Input.is_action_pressed("ui_left"):
	# 	velocity.x = -speed
	# 	#velocity.y = 0
	# elif Input.is_action_pressed("ui_up"):
	# 	#velocity.x = 0
	# 	velocity.y = -speed
	# elif Input.is_action_pressed("ui_down"):
	# 	#velocity.x = 0
	# 	velocity.y = speed
	# else:
	# 	velocity.x = 0
	# 	velocity.y = 0
	input = get_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * friction * delta
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func play_anim(_delta):
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	# faster animation speed when 'sprinting'
	if abs(velocity.x) > 100 || abs(velocity.y) > 100:
		$AnimatedSprite2D.speed_scale = 2
	else:
		$AnimatedSprite2D.speed_scale = 1
