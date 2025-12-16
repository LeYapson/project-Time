extends Area2D

@export var pull_strength := 300.0
@export var pull_radius := 200.0  # Rayon réduit
var is_reversed := false

func _physics_process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < pull_radius:  # Seulement si le joueur est proche
			var direction = (global_position - player.global_position).normalized()
			var impulse = direction * pull_strength * delta
			if is_reversed:
				player.apply_central_impulse(-impulse)  # Repousse en rewind
			else:
				player.apply_central_impulse(impulse)   # Attire en normal

func invert_pull():
	is_reversed = not is_reversed
