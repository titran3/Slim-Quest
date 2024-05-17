extends CharacterBody2D


@export var movement_data: PlayerMovementData

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_wall_normal = Vector2.ZERO
var air_jump = false
var just_wall_jumped = false
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $"Coyote Jump Timer"
@onready var starting_position = global_position
@onready var wall_jump_timer = $"Wall Jump Timer"
@onready var player = $"."
@onready var wall_jump_sfx = $"Wall Jump"
@onready var jump_land = $"Jump land"
@onready var jumping_sfx = $"Jumping sfx"

func _physics_process(delta):
	apply_gravity(delta)
	handle_wall_jump()
	handle_jump()
	var input_axis = Input.get_axis("move_left", "move_right")
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	update_animation(input_axis)
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall_only()
	if was_on_wall:
		was_wall_normal = get_wall_normal()
	move_and_slide() 
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge: 
		coyote_jump_timer.start()
	just_wall_jumped = false
	var just_left_wall = was_on_wall and not is_on_wall()
	if just_left_wall:
		wall_jump_timer.start()
	
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

func handle_wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left <= 0.0:
		return

	var wall_normal = get_wall_normal()
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal

	if Input.is_action_just_pressed("jump"):
		wall_jump_sfx.play()
		velocity.x = wall_normal.x * movement_data.speed
		velocity.y = movement_data.jump_velocity
		just_wall_jumped = true

		# Flip character sprite if necessary
		if wall_normal.x < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	
func handle_jump():
	if is_on_floor(): 
		air_jump = true
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump"):
			jumping_sfx.play()
			velocity.y = movement_data.jump_velocity
			air_jump = true  # Reset air_jump when jumping from the ground
	elif air_jump:  # Check if double jump is allowed
		if Input.is_action_just_pressed("jump"):
			jumping_sfx.play()
			velocity.y = movement_data.jump_velocity
			air_jump = false  # Disable double jump after using it


func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)
		
func update_animation(input_axis):
	if is_on_floor():
		if input_axis != 0:
			animated_sprite_2d.flip_h = (input_axis < 0)
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("jump")
		
func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x , 0, movement_data.air_resistance * delta)
