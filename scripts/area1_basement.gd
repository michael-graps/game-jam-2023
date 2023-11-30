extends Node2D

@onready var pause_menu = $Player/pmenu_location_move
var paused = false

@export var roomtone: EventAsset
@export var music: EventAsset
var instance: EventInstance
var tonestance: EventInstance

var music_start = 0
var stop_music = 1

var Credits: float = 0.0

func _on_area_2_transition_body_entered(body):
	print("Teleporting to Area 2: The Kitchen BOTTOM LEFT")
	PlayerPositionManager.set_prev_area(2)
	PlayerCollectionsTracker.allgotten_check()
	instance.set_parameter_by_name("stop_music", stop_music, false)
	tonestance.stop(FMODStudioModule.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	get_tree().change_scene_to_file("res://scenes/area2_kitchen.tscn")

func _ready() -> void:
	Engine.max_fps = 60
	instance = FMODRuntime.create_instance(music)
	tonestance = FMODRuntime.create_instance(roomtone)
	tonestance.start()
	if PlayerPositionManager.prev_area == 5:
		instance.start()
	pause_menu.hide()

func _process(delta) -> void:
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
