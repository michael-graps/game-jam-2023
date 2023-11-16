extends CharacterBody2D

@export var event: EventAsset

@export var move_speed : float = 200
@export var air_jumps_total : int = 1
var air_jumps_current : int = air_jumps_total

var is_climbing = false
var just_walljumped = false

var anim_counter = 0

@export var climb_speed : float = 50
@export var slide_speed : float = 50

@export var jump_height : float = 30
@export var air_jump_height : float = 55
@export var jump_time_to_peak : float = 0.25
@export var air_jump_time_to_peak : float = 0.30
@export var jump_time_to_descent : float = 0.25

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var air_jump_velocity : float = ((2.0 * air_jump_height) / air_jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var ap = $Sprite/AnimationPlayer

func _physics_process(delta):
	if is_on_floor():           # Checks to see if you're on the floor, sets is_climbing accordingly #
		is_climbing = false
	if is_climbing == true:
		climb()
	else:                       # If not climbing, starts making you move towards the floor #
		velocity.y += get_gravity() * delta
	velocity.x = get_horizontal_velocity() * move_speed
	
	
	if $WalljumpTimer.time_left <= 0:
		just_walljumped = false
	
	if Input.is_action_just_pressed("jump_button"):
		if is_on_floor():
			jump()
		if air_jumps_current > 0 and not is_on_floor() and just_walljumped == false:
			air_jump()
	
	if Input.is_action_pressed("climb_button") and is_on_wall_only() and just_walljumped == false:
		air_jumps_current = 0
		is_climbing = true
		
	if Input.is_action_just_released("climb_button") and is_climbing == true:
		is_climbing = false
	
	var direction = Input.get_axis("left_button", "right_button")
	walk_sound_trigger()
	if direction and is_climbing == false:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	move_and_slide()
	var horizontal_direction = Input.get_axis("left_button","right_button")
	update_animations(horizontal_direction)
	

# Function that gives you gravity as a float #
func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("walk")
	elif is_climbing == true:
			ap.play("climbing")
			if velocity.y == 0:
				ap.play("climb_start")
	else:
		if Input.is_action_just_pressed("jump_button"):
			ap.play("jump_start")
		if velocity.y < 0:
			ap.queue("jump")
		elif velocity.y > 0:
			ap.play("fall")

# Function that handles climbing #
func climb():
	var climb_direction = Input.get_axis("up_button", "down_button")
	var walljump_direction = Input.get_axis("left_button", "right_button")
	if walljump_direction and is_on_wall_only() and Input.is_action_just_pressed("jump_button"):
		jump()
		velocity.x = walljump_direction * move_speed
		is_climbing = false
		just_walljumped = true
		$WalljumpTimer.start()
		return
	if climb_direction and is_on_wall_only() and is_climbing == true:
		velocity.y = climb_direction * climb_speed
		just_walljumped = false
	else:
		velocity.y = 0

func jump():
	air_jumps_current = air_jumps_total
	velocity.y = jump_velocity
	
func air_jump():
	air_jumps_current -= 1
	velocity.y = air_jump_velocity

# This function gets horizontal velocity #
# and also flips the sprite to face movement direction #
func get_horizontal_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("left_button"):
		$Sprite.flip_h = true
		horizontal -= 1.0
	if Input.is_action_pressed("right_button"):
		$Sprite.flip_h = false
		horizontal += 1.0
	
	return horizontal

# This function handles triggering the FMOD Walk Sound #
func walk_sound_trigger():
	if velocity.x != 0 and is_on_floor() and $WalkSoundTimer.time_left <= 0:
		FMODRuntime.play_one_shot(event)
		$WalkSoundTimer.start()
