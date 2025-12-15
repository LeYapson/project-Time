extends Area2D

func _on_body_entered(body):
	print("collision !")
	if body.name == "Player":
		body.die()
