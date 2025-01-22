extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var fall_state = 0
#0 = no animation
#1 = tiny
#2 = big
var jump_var = false
var score 
var Health = 3
var state = 0
#state -1 = startup
#State 0 = nothing
#state 1 = attacking
#state 2 = ready jump
#state 3 = hurt
#state 4 = death
#state 5 = movement to fix idle

@onready var hp: Label = $Health

@onready var animation: AnimatedSprite2D = $Flip/AnimatedSprite2D
@onready var capsule: CollisionShape2D = $Flip
@onready var landing: Timer = $Landing
@onready var jump: Timer = $jump
@onready var timer: Timer = $Timer
@onready var smoother_jump: Timer = $"Smoother jump"
@onready var hitbox: CollisionShape2D = $Flip/AnimatedSprite2D/Area2D/CollisionShape2D
@onready var startup: Timer = $startup
@onready var hurtbox: Area2D = $Flip/AnimatedSprite2D/hurtbox
@onready var i_frames: Timer = $Flip/AnimatedSprite2D/hurtbox/iFrames
@onready var dt: Timer = $Flip/AnimatedSprite2D/hurtbox/deathTimer
@onready var score_ui: Label = $Camera2D/scoreUI


func _ready() -> void:
	score = get_parent().get_node("Score")

func _physics_process(delta: float) -> void:
	if state == 4:
		velocity.x = 0.0
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		#landing.start()
		#timer.start()
		
	#attacking Hitbox
	if animation.get_frame() in [2, 3, 4, 9, 10,11, 16, 17, 18] and state == 1:
		hitbox.disabled = false
	else:
		hitbox.disabled = true

	
	print(str(state))

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	
	#kääntää spriten oikeeseen suuntaan
	if Input.is_action_pressed("ui_right") == true:
		capsule.scale = Vector2(1.0, 1.0)
	elif Input.is_action_pressed("ui_left"):
		capsule.scale = Vector2(-1.0, 1.0)

	#Attack animation
	if Input.is_action_pressed("attack") and is_on_floor():
		animation.play("attack")
		state = 1
	elif state == 1:
		state = 0
	#Fall and landing animations
	if is_on_floor() and fall_state == 2:
		animation.play("landing")

	elif is_on_floor() and fall_state == 1:
		animation.play("mini_landing")
		
	if jump_var == false and is_on_floor() == false:
		animation.play("fall")
	#Movement
	elif direction and state not in  [1, 3, 4]:
		velocity.x = direction * SPEED
	#Movement animation
		if is_on_floor():
				animation.play("run")
				if state != 2:
					state = 5
	#death
	elif state == 4:
		animation.play("ded")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if state not in [1, 3, 4]:
			state = 0
		
		if fall_state not in [1, 2] and state not in  [1, 3, 4, 5] and is_on_floor():
			animation.play("default")
			state = 0
				
				
		# Handle jump.
	if (Input.is_action_just_pressed("ui_accept") and is_on_floor()) or (state == 2 and is_on_floor()):
		velocity.y = JUMP_VELOCITY
		animation.play("Jomp")
		jump_var = true
		jump.start()
		smoother_jump.start()
		
	if Input.is_action_pressed("ui_accept") and is_on_floor() == false:
		state = 2
		smoother_jump.start()
			
				
	move_and_slide()


func _on_landing_timeout() -> void:
	if is_on_floor() == false:
		fall_state = 2
	else:
		pass


func _on_animated_sprite_2d_animation_finished() -> void:
	
		fall_state = 0
		
	

func _on_jump_timeout() -> void:
	jump_var = false
	


func _on_timer_timeout() -> void:
	if is_on_floor() == false:
		fall_state = 1


func _on_smoother_jump_timeout() -> void:
	state = 0


func _on_startup_timeout() -> void:
	state = 0

#makes it so you can take damage

func _on_hurtbox_area_entered(area: Area2D) -> void:
	state = 3
	animation.play("hort")
	Health -= 1
	hp.text = "Health: " + str(Health)

	
	$Flip/AnimatedSprite2D/hurtbox/CollisionShape2D.disabled = true

	if Health > 0:
		i_frames.start()
	else:
		state = 4
		dt.start()
		
	


func _on_i_frames_timeout() -> void:
	
	$Flip/AnimatedSprite2D/hurtbox/CollisionShape2D.disabled = false
	state = 0
	


func _on_death_timer_timeout() -> void:
	
	get_tree().change_scene_to_file("res://death_screen.tscn")
	
		
	


func _on_score_timeout() -> void:
	score_ui.text = ("Score: " + str(get_parent().Score))
