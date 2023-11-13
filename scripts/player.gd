extends CharacterBody2D

@export var event: EventAsset

@export var move_speed : float = 200.0
@export var air_jumps_total : int = 1
var air_jumps_current : int = air_jumps_total

var is_climbing = false

@export var climb_speed : float = 200

@export var jump_height : float = 30
@export var jump_time_to_peak : float = 0.25
@export var jump_time_to_descent : float = 0.15

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _physics_process(delta):
	if is_on_floor():
		is_climbing = false
	if is_climbing == true:
		climb()
	else:
		velocity.y += get_gravity() * delta
	velocity.x = get_horizontal_velocity() * move_speed
	
	if Input.is_action_just_pressed("jump_button"):
		if is_on_floor():
			jump()
#		if is_on_wall_only():
#			wall_jump()
		if air_jumps_current > 0 and not is_on_floor():
			air_jump()
	
	if Input.is_action_pressed("climb_button") and is_on_wall_only():
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

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func climb():
	var climb_direction = Input.get_axis("up_button", "down_button")
	if climb_direction and is_on_wall_only():
		velocity.y = climb_direction * climb_speed
	else:
		velocity.y = 0

func jump():
	air_jumps_current = air_jumps_total
	velocity.y = jump_velocity
	
func air_jump():
	air_jumps_current -= 1
	velocity.y = jump_velocity
	
func wall_jump():
	is_climbing = false
	if $WalkSoundTimer.time_left <= 0:
		is_climbing = true
	velocity.y = jump_velocity
	

func get_horizontal_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("left_button"):
		horizontal -= 1.0
		$Sprite.flip_h = true
	if Input.is_action_pressed("right_button"):
		$Sprite.flip_h = false
		horizontal += 1.0
	
	return horizontal

func walk_sound_trigger():
	if velocity.x != 0 and is_on_floor() and $WalkSoundTimer.time_left <= 0:
		FMODRuntime.play_one_shot(event)
		$WalkSoundTimer.start()
