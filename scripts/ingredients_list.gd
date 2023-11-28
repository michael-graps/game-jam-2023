extends Area2D

func _on_body_entered(body):
	if Input.is_action_just_pressed("interact_button"):
		queue_free()
		print("FUCK")
