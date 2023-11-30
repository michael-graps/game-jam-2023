extends Node2D

@onready var candle_ap = $candle_light/candle_player
@onready var candle_ap2 = $candle_light2/candle_player
@onready var candle_ap3 = $candle_light3/candle_player
@onready var candle_ap4 = $candle_light4/candle_player
@onready var candle_ap5 = $candle_light5/candle_player
@onready var candle_ap6 = $candle_light6/candle_player

@onready var pause_menu = $Player/pmenu_location_move
var paused = false

@export var music1: EventAsset
@export var roomtone: EventAsset
var tonestance: EventInstance

func _on_area_1_transition_body_entered(body):
	print("Teleporting to Area 1: The Basement END")
	PlayerPositionManager.set_prev_area(4)
	tonestance.stop(FMODStudioModule.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	Events.change_scene.emit("res://scenes/area1_basement.tscn")

func _on_area_1_top_transition_body_entered(body):
	print("Teleporting to Area 1: The Basement TOP")
	PlayerPositionManager.set_prev_area(5)
	tonestance.stop(FMODStudioModule.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	Events.change_scene.emit("res://scenes/area1_basement.tscn")


func _on_area_3_transition_body_entered(body):
	print("Teleporting to Area 3: The Attic")
	PlayerPositionManager.set_prev_area(3)
	tonestance.stop(FMODStudioModule.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	Events.change_scene.emit("res://scenes/area3_attic.tscn")

func _ready():
	Engine.max_fps = 60
	tonestance = FMODRuntime.create_instance(roomtone)
	tonestance.start()
	if PlayerPositionManager.area2_entered == 0:
		FMODRuntime.play_one_shot(music1)
		PlayerPositionManager.entered_kitchen_first_time()
	candle_ap.play("candle_light")
	candle_ap2.play("candle_light")
	candle_ap3.play("candle_light")
	candle_ap4.play("candle_light")
	candle_ap5.play("candle_light")
	candle_ap6.play("candle_light")
	pause_menu.hide()

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



