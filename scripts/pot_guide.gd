extends Node2D

@onready var light = $light/light_player
@onready var sparkle = $interaction_area/Sparkle
@onready var ui = $ui
@onready var interact = false

@export var fire: EventAsset
var instance: EventInstance
var stop_fire: int = 1

func _ready():
	light.play("light_movement")
	sparkle.play()
	ui.hide()
	if PlayerCollectionsTracker.everything_got == 1:
		instance = FMODRuntime.create_instance(fire)
		instance.start()
	

func _physics_process(delta):
	
	interactionenable()
	
	if PlayerCollectionsTracker.everything_got == 1:
		show()
	else:
		hide()

func interactionenable():
	if interact == true and Input.is_action_just_pressed("interact_button") and PlayerCollectionsTracker.everything_got == 1:
		instance.set_parameter_by_name("stop_fire", stop_fire, false)
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	else:
		pass


func _on_interaction_area_body_entered(body):
	ui.show()
	interact = true


func _on_interaction_area_body_exited(body):
	ui.hide()
	interact = false
