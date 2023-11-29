extends Node2D

@onready var light = $light/light_player
var showing = true

func _ready():
	light.play("light_movement")

func _physics_process(delta):
	if PlayerCollectionsTracker.everything_got == 1:
		show()
		showing = true
	else:
		hide()
		showing = false


func _on_interaction_area_body_entered(body):
	if Input.is_action_pressed("interact_button") and showing == true:
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
