extends Node2D


func _on_area_1_transition_body_entered(body):
	print("Teleporting to Area 1: The Basement")
	get_tree().change_scene_to_file("res://scenes/area1_basement.tscn")


func _on_area_3_transition_body_entered(body):
	print("I'd teleport to Area 3: The Attic, IF THERE WAS ONE. fucking idiot.")
