extends RigidBody2D

@export var speed := 200.0
@export var jump_force := -400.0
var is_rewinding := false
var saved_positions := []

func _physics_process(delta):
	# 1. Enregistrer la position ACTUELLE (toujours, pas seulement en rewind)
	saved_positions.append(position)
	if saved_positions.size() > 300:  # Garde les 300 dernières positions
		saved_positions.pop_front()

	# 2. Déplacement gauche/droite
	var input_x = Input.get_axis("move_left", "move_right")
	linear_velocity.x = input_x * speed

	# 3. Saut (adapté à la gravité)
	if Input.is_action_just_pressed("jump"):
		if is_rewinding:
			linear_velocity.y = -jump_force  # Saut vers le bas en rewind
		else:
			linear_velocity.y = jump_force   # Saut vers le haut en normal

func die():
	is_rewinding = true
	$Sprite2D.modulate = Color(0, 0, 1)
	gravity_scale = -1

	# Inverse les lasers
	var lasers = get_tree().get_nodes_in_group("lasers")
	for laser in lasers:
		laser.invert_direction()

	# Inverse les plateformes mobiles
	var platforms = get_tree().get_nodes_in_group("moving_platforms")
	for platform in platforms:
		platform.invert_direction()

	# Inverse les trous noirs
	var black_holes = get_tree().get_nodes_in_group("black_holes")
	for black_hole in black_holes:
		black_hole.invert_pull()

	# Rotation de la caméra
	var camera = get_tree().get_first_node_in_group("camera")
	if camera:
		camera.rotation_degrees = 180

	await rewind()

	# Remet tout à la normale
	gravity_scale = 1
	is_rewinding = false
	$Sprite2D.modulate = Color(1, 1, 1)
	if camera:
		camera.rotation_degrees = 0
	for laser in lasers:
		laser.invert_direction()
	for platform in platforms:
		platform.invert_direction()
	for black_hole in black_holes:
		black_hole.invert_pull()  # Réinverse les trous noirs


func rewind():
	var timer = 0.0
	# Rejoue les positions à l'envers
	while saved_positions.size() > 0 and timer < 3.0:
		position = saved_positions.pop_back()
		await get_tree().create_timer(0.02).timeout  # Attend 20ms
		timer += 0.02
