extends CharacterBody2D

@export var move_speed : float = 200
@export var air_jumps_total : int = 0
var air_jumps_current : int = air_jumps_total

var is_climbing = false
var just_walljumped = false

var anim_counter = 0
var has_jumped = false

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


@onready var c_time = $coyote_timer
@onready var ap = $Sprite/AnimationPlayer
@onready var glow = $mushroom_glow/glow_player
@onready var climb_cast_left = $climb_raycast_left
@onready var climb_cast_right = $climb_raycast_right
@onready var climb_cast_down = $climb_raycast_down
@onready var tile_map : TileMap = %TileMap
var has_cheese = false
@onready var has_spice = false
@onready var has_water = false
var direction
var airjumpenabled = 0
#var is_climbable_l = false
#var is_climbable_r = false

func _ready():
	glow.play("glow")
	if PlayerPositionManager.prev_area == 1:
		position.x = 1738
		position.y = 383
	elif PlayerPositionManager.prev_area == 2:
		position.x = -357
		position.y = 638
	elif PlayerPositionManager.prev_area == 3:
		position.x = 2
		position.y = 106
	elif PlayerPositionManager.prev_area == 4:
		position.x = 3463
		position.y = 160
	elif PlayerPositionManager.prev_area == 5:
		position.x = 3456
		position.y = -561
	elif PlayerPositionManager.prev_area == 6:
		position.x = 1158
		position.y = 287
	else:
		pass



func _physics_process(delta):
	if is_on_floor() or is_colliding_wall() == false:           # Checks to see if you're on the floor, sets is_climbing accordingly #
		is_climbing = false
	
	if is_on_floor():
		has_jumped = false

	if is_climbing == true:
		climb()
	else:                       # If not climbing, starts making you move towards the floor #
		velocity.y += get_gravity() * delta
	velocity.x = get_horizontal_velocity() * move_speed
	
	if $WalljumpTimer.time_left <= 0:
		just_walljumped = false
	if Input.is_action_just_pressed("jump_button"):
		if (is_on_floor() or c_time.time_left > 0) and is_climbing == false and has_jumped == false:
			jump()
		if air_jumps_current > 0 and not is_on_floor() and just_walljumped == false and c_time.time_left <= 0:
			air_jump()
	
	if Input.is_action_pressed("climb_button") and is_colliding_wall() and just_walljumped == false and is_on_wall_only():
		air_jumps_current = 0
		is_climbing = true
		
	if Input.is_action_just_released("climb_button") and is_climbing == true:
		is_climbing = false
	
	direction = Input.get_axis("left_button", "right_button")
	if direction and is_climbing == false:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	var horizontal_direction = Input.get_axis("left_button","right_button")
	update_animations(horizontal_direction)
	
	if was_on_floor:
		air_jumps_current = air_jumps_total
	
	if was_on_floor and is_on_floor() == false and has_jumped == false:
		c_time.start()
	
	if airjumpenabled == 0:
		airjump_enabler()
	
	

func airjump_enabler():
	if PlayerCollectionsTracker.part1_got == 1:
		air_jumps_total = 1
		air_jumps_current = air_jumps_total
		airjumpenabled = 1

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
			
func is_climbable(tile_data : TileData, cast : RayCast2D):
	
	if cast.is_colliding():
		if tile_data:
			return tile_data.get_custom_data("is_climbable")
		else:
			return false
	else:
		return false
		
func get_tile_data(cast : RayCast2D, is_left : bool):
	if is_left:
		return is_climbable(tile_map.get_cell_tile_data(3, get_left_tile_coords(tile_map.local_to_map(cast.get_collision_point()))), cast)
	else:
		return is_climbable(tile_map.get_cell_tile_data(3,tile_map.local_to_map(cast.get_collision_point())), cast)
	
func get_left_tile_coords(tile_vector):
	tile_vector.x -= 1
	return tile_vector
		
func is_colliding_wall():
	var is_climbable = get_tile_data(climb_cast_left, true) or get_tile_data(climb_cast_right, false)
	return ((climb_cast_left.is_colliding() or climb_cast_right.is_colliding()) and is_climbable and climb_cast_down.is_colliding() == false)

# Function that handles climbing #
func climb():
	var climb_direction = Input.get_axis("up_button", "down_button")
	var walljump_direction = Input.get_axis("left_button", "right_button")
	if walljump_direction and is_colliding_wall() and Input.is_action_just_pressed("jump_button") and !(direction < 0 and climb_cast_left.is_colliding()) and !(direction > 0 and climb_cast_right.is_colliding()):
		jump()
		velocity.x = walljump_direction * move_speed
		is_climbing = false
		just_walljumped = true
		$WalljumpTimer.start()
		return
	if climb_direction and is_colliding_wall() and is_climbing == true:
		velocity.y = climb_direction * climb_speed
		just_walljumped = false
	else:
		velocity.y = 0

func jump():
	has_jumped = true
	velocity.y = jump_velocity
	
func air_jump():
	air_jumps_current -= 1
	velocity.y = air_jump_velocity
	
func set_has_cheese():
	has_cheese = true


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

