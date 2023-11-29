extends Node2D

func _on_area_2_transition_body_entered(body):
	print("Teleporting to Area 2: The Kitchen BOTTOM LEFT")
	PlayerPositionManager.set_prev_area(2)
	PlayerCollectionsTracker.allgotten_check()
	get_tree().change_scene_to_file("res://scenes/area2_kitchen.tscn")

func _ready():
	Engine.max_fps = 60
