extends Area2D

@export var pull_strength := 500.0
var is_reversed := false

func _physics_process(delta):
	# Trouve le joueur (optimisé)
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = global_position - player.global_position
		if direction.length() < 300:  # Rayon d'attraction
			var impulse = direction.normalized() * pull_strength * delta
			if is_reversed:
				player.apply_central_impulse(-impulse)  # Repousse en mode rewind
			else:
				player.apply_central_impulse(impulse)   # Attire en mode normal

func invert_pull():
	is_reversed = not is_reversed  # Inverse le comportement
