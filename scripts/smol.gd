extends CharacterBody2D

@export var event: EventAsset

const SPEED = 500.0
const JUMP_VELOCITY = -600.0
const CLIMB_SPEED = 350.0  # Adjust the climbing speed as needed

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity")* 1.3)

var is_climbing = false
var is_wall_jump = false

func _physics_process(delta):

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		is_climbing = false
		
	if is_climbing and is_on_wall_only():
		velocity.y = 0
		var climb_direction = Input.get_axis("ui_up", "ui_down")
		velocity.y = climb_direction * CLIMB_SPEED
		
	var direction = Input.get_axis("ui_left", "ui_right")
	
	move_and_slide()
	walk_sound_trigger()
	jump(direction)
	climb(direction)

func jump(direction):
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_accept") and is_climbing and is_on_wall_only():
		is_climbing = false
		is_wall_jump = true
		velocity.y = JUMP_VELOCITY
		velocity.x = direction * SPEED
		
func climb(direction):
	# Handle Climbing.
	if (Input.is_action_just_pressed("ui_climb") and is_on_wall_only()):
		is_climbing = true
	if ((Input.is_action_just_released("ui_climb") and is_climbing == true) ):
		is_climbing = false
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if direction and is_climbing == false:
		velocity.x = direction * SPEED
	elif is_climbing == false:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func walk_sound_trigger():
	if velocity.x != 0 and is_on_floor() and $WalkSoundTimer.time_left <= 0:
		FMODRuntime.play_one_shot(event)
		$WalkSoundTimer.start()
		
