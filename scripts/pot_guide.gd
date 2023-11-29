extends Node2D

@onready var light = $light/light_player
@onready var sparkle = $interaction_area/Sparkle
@onready var ui = $ui
@onready var interact = false

func _ready():
	light.play("light_movement")
	sparkle.play()
	ui.hide()

func _physics_process(delta):
	
	interactionenable()
	
	if PlayerCollectionsTracker.everything_got == 1:
		show()
	else:
		hide()

func interactionenable():
	if interact == true and Input.is_action_just_pressed("interact_button"):
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	else:
		pass


func _on_interaction_area_body_entered(body):
	ui.show()
	interact = true


func _on_interaction_area_body_exited(body):
	ui.hide()
	interact = false
