extends Node2D

@onready var pause_menu = $Player/pmenu_location_move
var paused = false
@export var roomtone: EventAsset

func _ready():
	Engine.max_fps = 60
	pause_menu.hide()

func _on_area_2_transition_body_entered(body):
	print("Teleporting to Area 2: The Kitchen TOP RIGHT")
	PlayerPositionManager.set_prev_area(6)
	Events.change_scene.emit("res://scenes/area2_kitchen.tscn")

func _process(delta):
	if Input.is_action_just_pressed("pause_button"):
		pausemenu()


func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
