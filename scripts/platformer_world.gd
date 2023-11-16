extends Node2D

func _on_world_2_transition_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/platformer_world_2.tscn")
